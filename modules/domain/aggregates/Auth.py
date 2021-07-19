from modules.domain.entities import User
from PySide2.QtCore import QObject, Signal, Slot


class Data(QObject):
    def __init__(self):
        QObject.__init__(self)

    account = None
    token = None

    @Slot(str, str)
    def sign_in(self, email: str, password: str):
        try:
            self.account = User.Account.sign_in(email, password)
            return self.account
        except User.AccountNotFound as ex:
            return ex

    @Slot()
    def register(self, first_name: str, last_name: str, company: str, email: str, password: str):
        self.account = User.Account.register(first_name, last_name, company, email, password)
