import re


def email_format(value: str) -> bool:
    r"""
    Description of regular expression:
    Local part:
        It can consist of alphanumeric or any other symbols between ! and ~
        [\w!#$%&‘*+–/=?^_`.{|}~]{1,64}
    @
    Domain part:
        Each of Domain labels except the last.
        They start and end with alphanumeric while could contain `-` symbol inside
        [a-zA-Z\d][a-zA-Z\d-]+[a-zA-Z\d]\.

        Last Domain label. It should contain alphabetic symbol.
        [a-zA-Z\d]*[a-zA-Z][a-zA-Z\d]*
    """
    regex = r"^[\w!#$%&‘*+–\/=?^_`.{|}~]+[@]([a-zA-Z\d][a-zA-Z\d-]+[a-zA-Z\d]\.)+([a-zA-Z\d]*[a-zA-Z][a-zA-Z\d]*)$"

    email_parts = value.split("@")
    if len(email_parts) != 2 or len(email_parts[0]) > 64 or len(email_parts[1]) > 255:
        return False

    return bool(re.search(regex, value))


def password_policy(value: str) -> bool:
    """
    Check if given password is compliant with the OWASP Security standards
    """

    owasp_special_characters = "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~"

    complexity_rules = [
        lambda s: any(x.isupper() for x in s),
        lambda s: any(x.islower() for x in s),
        lambda s: any(x.isdigit() for x in s),
        lambda s: any(x in owasp_special_characters for x in s)
    ]
    rules_score = sum([rule(value) for rule in complexity_rules])
    return rules_score >= 3 and 10 <= len(value) <= 128


def first_name(value: str):
    error = not bool(value)
    empty = not bool(value)
    return error, empty


def last_name(value: str):
    error = not bool(value)
    empty = not bool(value)
    return error, empty


def company(value: str):
    error = not bool(value)
    empty = not bool(value)
    return error, empty


def email(value: str):
    error = not email_format(value)
    empty = not bool(value)
    return error, empty


def password(value: str):
    error = not password_policy(value)
    empty = not bool(value)
    return error, empty
