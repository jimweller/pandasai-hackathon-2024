# Use an appropriate base image, e.g., python:3.11-slim
# FROM --platform=linux/amd64 public.ecr.aws/docker/library/python:3-slim
FROM public.ecr.aws/docker/library/python:3.10-slim

# uncomment this to get the cx-oracle driver to build and get cached. recomment for deployment to AWS app runner.
#RUN apt-get update && apt-get install -y gcc


# Set environment variables (e.g., set Python to run in unbuffered mode)
ENV PYTHONUNBUFFERED 1

# Set the working directory
WORKDIR /app

# Copy your application's requirements and install them
COPY requirements.txt /app/

# install the requirements
RUN pip install -r /app/requirements.txt

# Copy your application code into the container
COPY app.py chainlit.md pandasai.json /app/
COPY .chainlit /app/.chainlit

# Expose the port that your app runs on
EXPOSE 8080

# Run your application
CMD ["python", "-m", "chainlit", "run", "app.py", "-h", "--port", "8080"]