import os

import chainlit as cl

import boto3

import pandasai
from pandasai import Agent
from pandasai.connectors import PostgreSQLConnector
from pandasai.llm.local_llm import LocalLLM
from pandasai.llm import BedrockClaude


aws_ec2_instance = PostgreSQLConnector(
    config={
        "table": "aws_ec2_instance",
    },
    field_descriptions = {
        "account_id": "aws account number, 12 digit number",
        "region": "the geographic region where the ec2 instance is deployed, us-west-2 is Oregon, us-east-1 is Virginia, us-west-1 is California, us-east-2 is Ohio, eu-west-1 is Ireland, eu-central-1 is Frankfurt, ap-southeast-1 is Singapore, ap-southeast-2 is Sydney, ap-northeast-1 is Tokyo, ap-northeast-2 is Seoul, sa-east-1 is Sao Paulo, ca-central-1 is Canada, eu-west-2 is London, eu-west-3 is Paris, eu-north-1 is Stockholm, ap-south-1 is Mumbai, me-south-1 is Bahrain, af-south-1 is Cape Town, eu-south-1 is Milan, ap-east-1 is Hong Kong, us-gov-east-1 is AWS GovCloud (US-East), us-gov-west-1 is AWS GovCloud (US-West), cn-north-1 is Beijing, cn-northwest-1 is Ningxia",
        "arn": "aws resource name",
        "instance_id": "the unique identifier for the ec2 instance, starts with i-",
        "image_id": "the unique identifier for the ami used to launch the ec2 instance",
        "instance_type": "the type of ec2 instance, class and size are separated by a period, class.size",
        "subnet_id": "the subnet where the ec2 instance is deployed",
        "title": "the name of the ec2 instance",
        "vpc_id": "the virtual private cloud where the ec2 instance is deployed",
        "volume_count": "the number of ebs volumes attached to the ec2 instance"
    }
)


ec2_to_ebs = PostgreSQLConnector(
    config={
        "table": "ec2_to_ebs",
    },
    field_descriptions = {
        "instance_id": "the unique identifier for the ec2 instance, foreign key to aws_ec2_instance.instance_id",
        "volume_id": "the unique identifier for the ebs volume, foreign key to aws_ebs_volume.volume_id"
    }
)


aws_ebs_volume = PostgreSQLConnector(
    config={
        "table": "aws_ebs_volume",
    },
    field_descriptions = {
        "account_id" : "aws account number",
        "arn" : "aws resource name",
        "availability_zone" : "aws availability zone",
        "encrypted" : "boolean, true if the ebs volume is encrypted",
        "region" : "aws region",
        "size" : "volume size in gigabytes",
        "snapshot_id" : "unique identifier for the snapshot",
        "title" : "name of the ebs volume",
        "volume_id" : "unique identifier for the ebs volume",
        "volume_type" : "disk type, standard, gp2, gp3, io1, io2, st1"
    }

)


aws_cloudwatch_log_group = PostgreSQLConnector(
    config={
        "table": "aws_cloudwatch_log_group",
    }
)


aws_ebs_snapshot = PostgreSQLConnector(
    config={
        "table": "aws_ebs_snapshot",
    },
    field_descriptions = {
        "account_id" : "asw account number",
        "arn text" : "aws resource name",
        "encrypted"  : "boolean, true if the snapshot is encrypted",
        "region"  : "aws region",
        "snapshot_id"  : "unique identifier for the snapshot",
        "volume_id"  : "unique identifier for the ebs volume that the snapshot was created from",
        "volume_size"  : "size of the ebs volume in gigabytes",
        "start_time"  : "the time the snapshot was created",
        "age_days"  : "the number of days since the snapshot was created"   
    }
)



bedrock_runtime_client = boto3.client('bedrock-runtime',region_name='us-east-1')
llm_bedrock = BedrockClaude(bedrock_runtime_client)


agent = Agent(
            [aws_ec2_instance,ec2_to_ebs,aws_ebs_volume,aws_cloudwatch_log_group,aws_ebs_snapshot],config={"llm": llm_bedrock},
            #vectorstore=vector_store
            )

@cl.on_chat_start
async def on_start():
    cl.user_session.set(
        "message_history",
        [{"role": "system", "content": "You are a helpful data analyst."}],
    )


@cl.on_message
async def on_message(message: cl.Message):

    # start a display loader animation
    msg = cl.Message(content="")
    await msg.send()


    # what did the user type for a question?
    question = message.content


    # get the users message history
    message_history = cl.user_session.get("message_history")
    
    # append this user question to the history
    message_history.append({"role": "user", "content": question})


    # send the question to the PandasAI agent
    response = agent.chat(question)

    # get the text part of the response
    msg.content=str(response)
    msg.elements = []

    # put the last code in a text element
    pandas_code = agent.last_code_executed
    text_item = cl.Text(name="", content=pandas_code, display="inline",language="python")
    msg.elements.append(text_item)


    # check if the reponse is an image file, if so, append it to the msg to display in the browser
    if str(response).endswith(".png"):
        # send the file download button
        image = cl.Image(path=response, name="Chart", display="inline", size="large")
        msg.elements.append(image)
        # dont' show the file path
        msg.content=""

    await msg.update()