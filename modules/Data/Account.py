from PySide2.QtCore import QObject, Signal, Slot, Property


class Data(QObject):
    def __init__(self, application):
        QObject.__init__(self)
        self._settings = application.settings

        self._token = self._settings.get_account_token()
        self._email = self._settings.get_account_email()
        self._account = None

    def get_token(self):
        return self._token

    def get_email(self):
        return self._email

    token_changed = Signal(str)
    email_changed = Signal(str)

    token = Property(str, get_token, notify=token_changed)
    email = Property(str, get_email, notify=email_changed)


