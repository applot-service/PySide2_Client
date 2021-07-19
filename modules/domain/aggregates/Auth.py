from modules.domain.entities import User
from PySide2.QtCore import QObject, Signal, Slot


class Data(QObject):
    def __init__(self):
        QObject.__init__(self)

    account = User.Account()
    token = None

