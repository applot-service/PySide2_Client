import os
import json
import requests

import jwt
import bcrypt

# AWS_ENDPOINT_URL = os.getenv('AWS_ENDPOINT_URL')
AWS_ENDPOINT_URL = "https://8pvqf6zuri.execute-api.us-east-1.amazonaws.com/Prod/"


def authenticate(email: str, password: str):
    payload = {
        "email": email,
        "password": password
    }

    url = AWS_ENDPOINT_URL + "auth_user"
    response = requests.get(url=url, params=payload)
    print(">>> RESPONSE:", response.json())


def register(first_name: str, last_name: str, company: str, email: str, password: str):
    payload = {
        "first_name": first_name,
        "last_name": last_name,
        "company": company,
        "email": email,
        "password": bcrypt.hashpw(password.encode(), bcrypt.gensalt()).decode()
    }

    url = AWS_ENDPOINT_URL + "create_user"
    response = requests.put(url=url, data=json.dumps(payload))
    print(">>> RESPONSE:", response.json(), response.status_code)
