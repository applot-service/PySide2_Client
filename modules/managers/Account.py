from PySide2.QtCore import QObject, Signal, Slot, Property
from modules.domain.entities import User
from modules.utilities.threading import Worker


def _sign_in(email: str, password: str):
    return User.Account.sign_in(
        email,
        password
    )


def _register(first_name: str, last_name: str,
              company: str, email: str, password: str):
    return User.register(
        first_name,
        last_name,
        company,
        email,
        password
    )


class Manager(QObject):
    def __init__(self, application):
        QObject.__init__(self)
        self.application = application
        self._token = None
        self._email = None
        self._account = None

    def get_token(self):
        return self._token

    def get_email(self):
        return self._email

    token_changed = Signal(str)
    email_changed = Signal(str)

    token = Property(str, get_token, notify=token_changed)
    email = Property(str, get_email, notify=email_changed)

    # Slots
    @Slot(str, str)
    def sign_in(self, email: str, password: str):
        worker = Worker(_sign_in, email=email, password=password)
        worker.signals.result.connect(self.sign_in_result)
        worker.signals.finished.connect(self.sign_in_finished)
        worker.signals.error.connect(self.sign_in_error)

        self.application.thread_pool.start(worker)

    @Slot(str, str, str, str, str)
    def register(self, first_name: str, last_name: str,
                 company: str, email: str, password: str):
        worker = Worker(_register,
                        first_name=first_name, last_name=last_name,
                        company=company, email=email, password=password)
        worker.signals.result.connect(self.register_result)
        worker.signals.finished.connect(self.register_finished)
        worker.signals.error.connect(self.register_error)

        self.application.thread_pool.start(worker)

    # Handlers
    def sign_in_result(self, account):
        self._account = None
        if account:
            self._account = account
            self._token = account.token
            self.token_changed.emit(self._token)
            self._email = account.email
            self.email_changed.emit(self._email)

    def sign_in_finished(self):
        print("FINISHED:")

    def sign_in_error(self, err):
        print("ERROR:", err)

    def register_result(self):
        print("REGISTER:")

    def register_finished(self):
        print("FINISHED:")

    def register_error(self, err):
        print("ERROR:", err)


