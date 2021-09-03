import os
import json
import requests

import jwt
import bcrypt

# AWS_ENDPOINT_URL = os.getenv('AWS_ENDPOINT_URL')
AWS_ENDPOINT_URL = "https://7h3d407kkg.execute-api.us-east-1.amazonaws.com/Prod/"


def create_empty_project():
    url = AWS_ENDPOINT_URL + "create_project"
    response = requests.put(url=url, data=None)
    print("[X] CREATE PROJECT RESPONSE:", response, "JSON:", response.json())
    return response.json()
