from dataclasses import dataclass, asdict
from modules.domain.actions import account as account_actions
from ApplotLibs.DataStructures import User

from typing import Optional


def register(first_name: str, last_name: str, company: str, email: str, password: str):
    account_actions.register(
        first_name=first_name,
        last_name=last_name,
        company=company,
        email=email,
        password=password
    )


@dataclass
class Account(User.Account):
    def to_dict(self):
        return asdict(self)

    @classmethod
    def from_dict(cls, source: dict) -> "Account":
        return cls(**source)

    @classmethod
    def sign_in(cls, email: str, password: str) -> Optional["Account"]:
        account_dict = account_actions.authenticate(email, password)
        if account_dict:
            return cls.from_dict(account_dict)
        return None

    def sign_out(self):
        pass
