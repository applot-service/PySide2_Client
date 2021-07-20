from PySide2.QtCore import QObject, Signal, Slot
from modules.utilities import validate


def _empty(value: str):
    if not value:
        return True
    else:
        return False


class IsValid(QObject):

    first_name_changed = Signal(bool)
    last_name_changed = Signal(bool)
    company_changed = Signal(bool)
    email_changed = Signal(bool)
    password_changed = Signal(bool)

    def __init__(self):
        QObject.__init__(self)
        self._first_name_has_error = False
        self._last_name_has_error = False
        self._company_has_error = False
        self._email_has_error = False
        self._password_has_error = False

    @Slot(str)
    def validate_first_name(self, value: str):
        self._first_name_has_error = _empty(value)
        self.first_name_changed.emit(self._first_name_has_error)

    @Slot(str)
    def validate_last_name(self, value: str):
        self._last_name_has_error = _empty(value)
        self.last_name_changed.emit(self._last_name_has_error)

    @Slot(str)
    def validate_company(self, value: str):
        self._company_has_error = _empty(value)
        self.company_changed.emit(self._company_has_error)

    @Slot(str)
    def validate_email(self, value: str):
        self._email_has_error = not validate.email_format(value)
        self.email_changed.emit(self._email_has_error)

    @Slot(str)
    def validate_password(self, value: str):
        self._password_has_error = not validate.password_policy(value)
        self.password_changed.emit(self._password_has_error)
