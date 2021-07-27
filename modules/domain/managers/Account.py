from PySide2.QtCore import QObject, Signal, Slot, Property
from modules.domain.entities import User
from modules.utilities.threading import thread


class Data(QObject):
    def __init__(self):
        QObject.__init__(self)
        self._token = None

    def get_token(self):
        return self._password

    token_changed = Signal(str)

    token = Property(str, get_token, notify=token_changed)

    # Slots
    @Slot()
    def sign_in(self):
        self._sign_in()

    @Slot()
    def register(self):
        self._register()

    # Threaded actions
    @thread
    def _sign_in(self):
        if all([
            self.email.validated,
            self.password.validated
                ]):
            account = User.Account.sign_in(
                self.email.value,
                self.password.value
            )

    @thread
    def _register(self):
        if all([
            self.first_name.validated,
            self.last_name.validated,
            self.company.validated,
            self.email.validated,
            self.password.validated
        ]):
            User.register(
                self.first_name.value,
                self.last_name.value,
                self.company.value,
                self.email.value,
                self.password.value
            )
