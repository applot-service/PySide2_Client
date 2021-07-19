import os
import requests

AWS_ENDPOINT_URL = os.getenv('AWS_ENDPOINT_URL')


def authenticate(email: str, password: str):
    print("AUTH", email, password)


def register(first_name: str, last_name: str, company: str, email: str, password: str):
    print("REGISTER", first_name, last_name, company, email, password)
