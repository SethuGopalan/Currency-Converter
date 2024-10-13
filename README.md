# Currency Converter App

This project is a Dockerized Currency Converter web application built with **Dash** for the frontend and a **Flask API** for the backend. The app allows users to input an amount, select two currencies to convert between them, and communicates with a Flask API that handles the conversion using the `currency_converter` library.

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
