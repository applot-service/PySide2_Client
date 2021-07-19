from dataclasses import dataclass, field, asdict
from modules.domain import actions
from typing import List


class AccountNotFound(Exception):
    pass


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
    def sign_in(cls, email: str, password: str) -> "Account":
        account = actions.account.authenticate(email, password)
        if account is None:
            raise AccountNotFound
        return cls.from_dict(account)

    def sign_out(self):
        pass

    def register(self):
        pass
