import dash
from dash import dcc, html, Output, Input
from currency_converter import CurrencyConverter
import pandas as pd
import requests

data = ["USD", "EUR", "GBP", "JPY", "AUD", "CAD", "CHF", "CNY", "INR", "BRL",
        "ZAR", "RUB", "SGD", "HKD", "NZD", "KRW", "MXN", "SEK", "NOK", "DKK",
        "MYR", "IDR", "PHP", "THB", "VND", "TRY", "AED", "SAR", "ARS", "EGP",
        "PKR", "ILS", "PLN", "HUF", "CZK", "NGN", "KES", "COP", "TWD", "CLP",
        "RON", "PEN", "LKR", "BDT", "QAR", "KWD", "BHD", "OMR", "MAD", "UAH"]

app = dash.Dash(__name__)

app.layout = html.Div([
    html.H1("Currency Converter", 
            style={'textAlign': 'center', 'color': 'white', 'marginBottom': '50px'}),
    
    dcc.Input(id="Cur_id", type="number", placeholder="Enter the Amount",
              style={'width': '200px', 'padding': '10px', 'fontSize': '16px', 'textAlign': 'center',
                       'border': '2px solid #4CAF50', 'borderRadius': '10px','marginRight': '10px'}),
    
    html.Br(), html.Br(),
    
    html.Div([
        dcc.Dropdown(id="Cur_ex_Id",
                     options=[{'label': Cur, 'value': Cur} for Cur in data],
                     value='USD', style={'width': '200px', 'padding': '10px', 'fontSize': '16px', 'border': 'none',
                                         'backgroundColor': '#f0f8ff'}),
        html.Br(),
        dcc.Dropdown(id="Cur_which_Id",
                     options=[{'label': xer, 'value': xer} for xer in data],
                     value='EUR', style={'width': '200px', 'padding': '10px', 'fontSize': '16px', 'border': 'none',
                                         'backgroundColor': '#f0f8ff'}),
    ], style={
        'backgroundColor': '#007BFF',  # Blue background for side panel
        'padding': '20px',
        'width': '220px',
        'position': 'fixed',
        'height': '100%',
        'top': '0',
        'left': '0'
    }),
    
    html.Br(), html.Br(),
    
    html.Button("Convert", id="Button-Id", n_clicks=0,
                style={'backgroundColor': 'white', 'color': 'blue', 'border': 'none',
                       'padding': '10px 20px', 'fontSize': '16px', 'borderRadius': '5px'}),
    
    html.Br(), html.Br(),
    
    html.Div(id="output-id", children="Enter the number", style={'fontSize': '20px', 'color': 'white'})
], style={
    'backgroundImage': 'url("/assets/africa-15428_1920.jpg")',  # Corrected path to the image
    'backgroundSize': 'cover',        # Ensure the background covers the whole page
    'backgroundPosition': 'center',   # Center the world map
    'height': '100vh',                # Full viewport height
    'display': 'flex',                # Flexbox for centering content
    'flexDirection': 'column',        # Align items vertically
    'alignItems': 'center',           # Vertically center content
    'justifyContent': 'center'        # Horizontally center content
})

@app.callback(
    Output("output-id", 'children'),
    [Input("Cur_id", 'value')],
    [Input("Cur_ex_Id", 'value')],
    [Input("Cur_which_Id", 'value')],
    [Input("Button-Id", 'n_clicks')]
)
def convert_Cur(rCur_value, Cur_value, target_val, n_clicks=0):
    if n_clicks == 0:
        return "Please enter a valid number and select a currency"

    if rCur_value is None or Cur_value is None or target_val is None:
        return "Please provide all values."

    response = requests.get('http://flask_api:5000/Cur', params={'value1': rCur_value, 'first_cur': Cur_value, 'sec_Cur': target_val})
    if response.status_code == 200:
        rate = response.json().get('rate')
        return f"Exchange value is {rate:.2f} {target_val}"
    else:
        return 'Error in API request.'

if __name__ == "__main__":
    app.run_server(host="0.0.0.0", port=8050)
