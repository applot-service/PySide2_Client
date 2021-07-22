from PySide2.QtCore import QObject, Signal, Slot, Property
from modules.utilities import validate


def _empty(value: str):
    if not value:
        return True
    else:
        return False


class FieldsErrors(QObject):
    def __init__(self):
        QObject.__init__(self)
        self._first_name_has_error = False
        self._last_name_has_error = False
        self._company_has_error = False
        self._email_has_error = False
        self._password_has_error = False
        self._all_fields_have_error = False

    # Slots
    @Slot(str)
    def validate_first_name(self, value: str):
        self._first_name_has_error = _empty(value)
        self.first_name_changed.emit(self._first_name_has_error)
        self._check_all_fields()

    @Slot(str)
    def validate_last_name(self, value: str):
        self._last_name_has_error = _empty(value)
        self.last_name_changed.emit(self._last_name_has_error)
        self._check_all_fields()

    @Slot(str)
    def validate_company(self, value: str):
        self._company_has_error = _empty(value)
        self.company_changed.emit(self._company_has_error)
        self._check_all_fields()

    @Slot(str)
    def validate_email(self, value: str):
        self._email_has_error = not validate.email_format(value)
        self.email_changed.emit(self._email_has_error)
        self._check_all_fields()

    @Slot(str)
    def validate_password(self, value: str):
        self._password_has_error = not validate.password_policy(value)
        self.password_changed.emit(self._password_has_error)
        self._check_all_fields()

    def _check_all_fields(self):
        if True not in (self._first_name_has_error, self._last_name_has_error,
                        self._company_has_error, self._email_has_error,
                        self._password_has_error):
            self._all_fields_have_error = False
            self.all_fields_changed.emit(False)
        else:
            self._all_fields_have_error = True
            self.all_fields_changed.emit(True)

    # Getters
    def _get_first_name(self):
        return self._first_name_has_error

    def _get_last_name(self):
        return self._last_name_has_error

    def _get_company(self):
        return self._company_has_error

    def _get_email(self):
        return self._email_has_error

    def _get_password(self):
        return self._password_has_error

    def _get_all_fields(self):
        return self._all_fields_have_error

    # Signals
    first_name_changed = Signal(bool)
    last_name_changed = Signal(bool)
    company_changed = Signal(bool)
    email_changed = Signal(bool)
    password_changed = Signal(bool)
    all_fields_changed = Signal(bool)

    # Properties
    first_name_has_error = Property(bool, _get_first_name, notify=first_name_changed)
    last_name_has_error = Property(bool, _get_last_name, notify=last_name_changed)
    company_has_error = Property(bool, _get_company, notify=company_changed)
    email_has_error = Property(bool, _get_email, notify=email_changed)
    password_has_error = Property(bool, _get_password, notify=password_changed)
    all_fields_have_error = Property(bool, _get_all_fields, notify=all_fields_changed)


class FieldsValues(QObject):
    def __init__(self):
        QObject.__init__(self)
        self._first_name = False
        self._last_name = False
        self._company = False
        self._email = False
        self._password = False
        self._all_fields_not_empty = False

    # Slots
    @Slot(str)
    def set_first_name(self, value: str):
        self._first_name = value
        self.first_name_changed.emit(self._first_name)
        self._check_all_fields()

    @Slot(str)
    def set_last_name(self, value: str):
        self._last_name = value
        self.last_name_changed.emit(self._last_name)
        self._check_all_fields()

    @Slot(str)
    def set_company(self, value: str):
        self._company = value
        self.company_changed.emit(self._company)
        self._check_all_fields()

    @Slot(str)
    def set_email(self, value: str):
        self._email = value
        self.email_changed.emit(self._email)
        self._check_all_fields()

    @Slot(str)
    def set_password(self, value: str):
        self._password = value
        self.password_changed.emit(self._password)
        self._check_all_fields()

    def _check_all_fields(self):
        pass

    # Getters
    def _get_first_name(self):
        return self._first_name

    def _get_last_name(self):
        return self._last_name

    def _get_company(self):
        return self._company

    def _get_email(self):
        return self._email

    def _get_password(self):
        return self._password

    def _get_all_fields(self):
        return self._all_fields_not_empty

    # Signals
    first_name_changed = Signal(bool)
    last_name_changed = Signal(bool)
    company_changed = Signal(bool)
    email_changed = Signal(bool)
    password_changed = Signal(bool)
    all_fields_changed = Signal(bool)

    # Properties
    first_name = Property(bool, _get_first_name, notify=first_name_changed)
    last_name = Property(bool, _get_last_name, notify=last_name_changed)
    company = Property(bool, _get_company, notify=company_changed)
    email = Property(bool, _get_email, notify=email_changed)
    password = Property(bool, _get_password, notify=password_changed)
    all_fields_not_empty = Property(bool, _get_all_fields, notify=all_fields_changed)
