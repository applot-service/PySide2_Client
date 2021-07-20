from PySide2.QtCore import QObject, Signal, Slot
from modules.utilities import validate


class IsValid(QObject):

    first_name_changed = Signal(bool)
    last_name_changed = Signal(bool)
    company_changed = Signal(bool)
    email_changed = Signal(bool)
    password_changed = Signal(bool)

    def __init__(self):
        QObject.__init__(self)
        self._first_name = False
        self._last_name = False
        self._company = False
        self._email = False
        self._password = False

    @Slot(str)
    def validate_first_name(self, value: str):
        if len(value) > 0:
            self._first_name = True
        else:
            self._first_name = False
        self.first_name_changed.emit()

    @Slot(str)
    def validate_last_name(self, value: str):
        if len(value) > 0:
            self._last_name = True
        else:
            self._last_name = False
        self.last_name_changed.emit()

    @Slot(str)
    def validate_company(self, value: str):
        if len(value) > 0:
            self._company = True
        else:
            self._company = False
        self.company_changed.emit()

    @Slot(str)
    def validate_email(self, value: str):
        if validate.email_format(value):
            self._email = True
        else:
            self._email = False
        print(">> validate_email", value, self._email)
        self.email_changed.emit(self._email)

    @Slot(str)
    def validate_password(self, value: str):
        if validate.password_policy(value):
            self._password = True
        else:
            self._password = False
        self.password_changed.emit()
