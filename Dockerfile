# Use an official Python runtime as a parent image
FROM python:3.9

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set the working directory to /app
WORKDIR /app

# Install dependencies
COPY Pipfile Pipfile.lock /app/
RUN pip install pipenv && pipenv install --system --deploy

# Copy the current directory contents into the container at /app
COPY . /app/

# Expose port 8000 for the Django app
EXPOSE 8000

# Run the command to start the Django app
