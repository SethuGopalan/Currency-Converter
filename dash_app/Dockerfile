# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install Dash and requests
RUN pip install dash requests pandas currencyconverter

# Make port 8050 available to the outside world
EXPOSE 8050

# Run the application
CMD ["python", "Cur_ex_Rate.py"]
