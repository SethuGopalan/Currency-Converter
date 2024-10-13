
# Currency Converter App

This project is a Dockerized Currency Converter web application built with **Dash** for the frontend and a **Flask API** for the backend. The app allows users to input an amount, select two currencies to convert between them, and communicates with a Flask API that handles the conversion using the `currency_converter` library.

## Screenshots

[Include some screenshots of your app's UI and functionality]

![App Screenshot](assets/Screenshort.png)

## Table of Contents
- [Project Structure](#project-structure)
- [Installation](#installation)
- [Usage](#usage)
- [API Endpoints](#api-endpoints)
- [Docker Setup](#docker-setup)

## Project Structure

```bash
.
├── assets/                 # Contains static assets (e.g., images)
├── flask_api/              # Contains Flask API for currency conversion
│   ├── __init__.py         # Initializes Flask app
│   ├── Cur_Rate_Api.py     # Flask API code
│   ├── Dockerfile          # Dockerfile for Flask API container
├── dash_app/               # Contains Dash frontend for user interaction
│   ├── __init__.py         # Initializes Dash app
│   ├── app.py              # Dash app code
│   ├── Dockerfile          # Dockerfile for Dash container
├── docker-compose.yml      # Docker Compose configuration
└── README.md               # This file
```

## Installation

### Requirements
- [Docker](https://www.docker.com/get-started)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Cloning the Repository

1. Clone the repository to your local machine:

   ```bash
   git clone <repository-url>
   cd currency-converter-app
   ```

2. **Configure Assets**:
   - Place your assets (e.g., map background image) in the `assets/` folder.

3. **Set up the Services**:
   - Ensure that the `docker-compose.yml` and Dockerfiles are correctly set up for both Flask and Dash services.

## Usage

### Running the Application with Docker

1. **Build and run the containers** using Docker Compose:
   ```bash
   docker-compose up --build
   ```

2. **Access the Application**:
   - The **Flask API** will be accessible at: `http://localhost:5000`
   - The **Dash frontend** will be accessible at: `http://localhost:8050`

### Stopping the Application

To stop the running containers, use:
```bash
docker-compose down
```

## API Endpoints

### Currency Conversion Endpoint

- **Endpoint**: `/Cur`
- **Method**: GET
- **Parameters**:
  - `value1`: The amount to be converted (e.g., 100).
  - `first_cur`: The source currency (e.g., `USD`).
  - `sec_Cur`: The target currency (e.g., `EUR`).
  
- **Example Request**:
  ```
  GET http://localhost:5000/Cur?value1=100&first_cur=USD&sec_Cur=EUR
  ```

- **Example Response**:
  ```json
  {
    "rate": 85.34
  }
  ```

## Docker Setup

### Docker Compose Overview

This project uses Docker Compose to orchestrate two services:

1. **flask_api**: The backend Flask API service that performs the currency conversion.
2. **dash_app**: The frontend Dash app for user interaction.

### docker-compose.yml Configuration

```yaml
version: "3"

services:
  flask_api:
    build: ./flask_api  # Builds the Flask API service
    container_name: flask_api
    ports:
      - "5000:5000"
    networks:
      - currency-net

  dash_app:
    build: ./dash_app  # Builds the Dash frontend
    container_name: dash_app
    ports:
      - "8050:8050"
    depends_on:
      - flask_api  # Dash app waits for Flask API to be ready
    networks:
      - currency-net

networks:
  currency-net:
    driver: bridge
```

### Dockerfiles

#### Flask API Dockerfile (`flask_api/Dockerfile`)

```dockerfile
# Use an official Python runtime as a base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install dependencies
RUN pip install -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define the command to run the app
CMD ["python", "Cur_Rate_Api.py"]
```

#### Dash App Dockerfile (`dash_app/Dockerfile`)

```dockerfile
# Use an official Python runtime as a base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install dependencies
RUN pip install -r requirements.txt

# Expose the port the app runs on
EXPOSE 8050

# Define the command to run the app
CMD ["python", "app.py"]
```
