from dataclasses import dataclass, field, asdict


@dataclass
class BaseError(BaseException):
    def to_dict(self):
        return asdict(self)


@dataclass
class SignInValidation(BaseError):
    type: str = field(default="sign in validation")
    message: str = field(default=None)


@dataclass
class AccountNotFound(BaseError):
    type: str = field(default="account")
    message: str = field(default="Account not found")


@dataclass
class EmailInvalid(BaseError):
    type: str = field(default="email")
    message: str = field(default="Email is invalid")


@dataclass
class PasswordNotCompliant(BaseError):
    type: str = field(default="password")
    message: str = field(default="Password is not compliant")
