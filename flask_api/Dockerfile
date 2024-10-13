# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install Flask and currency-converter
RUN pip install Flask flask-restful currencyconverter

# Make port 5000 available to the outside world
EXPOSE 5000

# Run the application
CMD ["python", "Curr_Rate._Api.py"]
