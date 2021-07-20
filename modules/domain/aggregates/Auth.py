from PySide2.QtCore import QObject, Signal, Slot

from modules.domain.entities import User
from modules.errors import (
    AccountNotFound,
    EmailInvalid,
    PasswordNotCompliant
)
from modules.utilities import validate


class Data(QObject):
    def __init__(self):
        QObject.__init__(self)

    account = None
    token = None

    response = Signal(int, str, str)  # status_code, response_type, response_message
    validation_response = Signal(str, bool)  # field_type, is_valid

    @Slot(str, str)
    def validate_field(self, field: str, value: str):
        pass

    @Slot(str, str)
    def sign_in(self, email: str, password: str):
        if not validate.email_format(email):
            self.response.emit(400, EmailInvalid.type, EmailInvalid.message)
            return
        if not validate.password_policy(password):
            self.response.emit(400, PasswordNotCompliant.type, PasswordNotCompliant.message)
            return

        self.response.emit(102, None, None)

        try:
            self.account = User.Account.sign_in(email, password)
            self.response.emit(200, None, None)
            return
        except AccountNotFound:
            return
            self.response.emit(404, AccountNotFound.type, AccountNotFound.message)

    @Slot()
    def register(self, first_name: str, last_name: str, company: str, email: str, password: str):
        self.account = User.Account.register(first_name, last_name, company, email, password)
