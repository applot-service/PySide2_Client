from dataclasses import dataclass, field, asdict
from modules.domain.actions import account as account_actions

from typing import List, Optional


def register(first_name: str, last_name: str, company: str, email: str, password: str):
    account_actions.register(
        first_name=first_name,
        last_name=last_name,
        company=company,
        email=email,
        password=password
    )


@dataclass
class ApplicationInfo:
    application_id: str = field(default=None)
    description: str = field(default=None)


@dataclass
class Account:
    first_name: str = field(default=None)
    last_name: str = field(default=None)
    company: str = field(default=None)
    email: str = field(default=None)
    password: str = field(default=None)
    token: str = field(default=None)
    applications: List[ApplicationInfo] = field(default=None)  # IDs

    def to_dict(self):
        return asdict(self)

    @classmethod
    def from_dict(cls, source: dict) -> "Account":
        return cls(**source)

    @classmethod
    def sign_in(cls, email: str, password: str) -> Optional["Account"]:
        account = account_actions.authenticate(email, password)
        if account:
            return cls.from_dict(account)
        return None

    def sign_out(self):
        pass
