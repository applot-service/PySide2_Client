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

    response = Signal(int, str, str)  # status_code, response_body

    @Slot(str, str)
    def sign_in(self, email: str, password: str):

        if not validate.email_format(email):
            self.response.emit(400, "email", EmailInvalid.message)
            return

        if not validate.password_policy(password):
            self.response.emit(400, "password", PasswordNotCompliant.message)
            return

        try:
            self.account = User.Account.sign_in(email, password)
            self.response.emit(200, None, None)
            return
        except AccountNotFound:
            return
            self.response.emit(404, AccountNotFound.message)

    @Slot()
    def register(self, first_name: str, last_name: str, company: str, email: str, password: str):
        self.account = User.Account.register(first_name, last_name, company, email, password)
