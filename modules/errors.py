from dataclasses import dataclass, field, asdict


@dataclass
class BaseError:
    def to_dict(self):
        return asdict(self)


@dataclass
class AccountNotFound(BaseError):
    message: str = field(default="Account not found")


@dataclass
class EmailInvalid(BaseError):
    message: str = field(default="Email is invalid")


@dataclass
class PasswordNotCompliant(BaseError):
    message: str = field(default="Password is not compliant")
