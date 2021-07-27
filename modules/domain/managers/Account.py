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


class Data(QObject):
    def __init__(self, shared_thread_pool):
        QObject.__init__(self)
        self.thread_pool = shared_thread_pool
        self._token = None
        self._account = None

    def get_token(self):
        return self._password

    token_changed = Signal(str)

    token = Property(str, get_token, notify=token_changed)

    # Slots
    @Slot(str, str)
    def sign_in(self, email: str, password: str):
        worker = Worker(_sign_in, email=email, password=password)
        worker.signals.result.connect(self.print_output)

        self.thread_pool.start(worker)

    @Slot(str, str, str, str, str)
    def register(self, first_name: str, last_name: str,
                 company: str, email: str, password: str):
        pass

