from PySide2.QtCore import QObject, Signal, Slot, Property
from dataclasses import dataclass, field
from modules.utilities import validate


@dataclass
class TypeFunction:
    type: str = field(default=None)
    function: str = field(default=None)


class FieldTypeValidationMap:
    first_name = TypeFunction("FIRST_NAME", validate.first_name)
    last_name = TypeFunction("LAST_NAME", validate.last_name)
    company = TypeFunction("COMPANY", validate.company)
    email = TypeFunction("EMAIL", validate.email)
    password = TypeFunction("PASSWORD", validate.password)


class Field(QObject):
    def __init__(self, field_type):
        QObject.__init__(self)
        self._type = field_type
        self._value = ""
        self._error = False
        self._empty = True
        self._validated = False

    @Slot(str)
    def set(self, field_value):
        if self._value == field_value:
            return
        self._value = field_value
        self._error, self._empty = self._type.function(self._value)
        self.error_changed.emit(self._error)
        self.empty_changed.emit(self._empty)
        if not self._error and not self._empty:
            self._validated = True
        else:
            self._validated = False
        self.validated_changed.emit(self._validated)

    def get_value(self):
        return self._value

    def get_error(self):
        return self._error

    def get_empty(self):
        return self._empty

    def get_validated(self):
        return self._validated

    error_changed = Signal(bool)
    empty_changed = Signal(bool)
    validated_changed = Signal(bool)

    value = Property(str, get_value)
    error = Property(bool, get_error, notify=error_changed)
    empty = Property(bool, get_empty, notify=empty_changed)
    validated = Property(bool, get_validated, notify=validated_changed)


class Manager(QObject):
    def __init__(self):
        QObject.__init__(self)
        self._first_name = Field(FieldTypeValidationMap.first_name)
        self._last_name = Field(FieldTypeValidationMap.last_name)
        self._company = Field(FieldTypeValidationMap.company)
        self._email = Field(FieldTypeValidationMap.email)
        self._password = Field(FieldTypeValidationMap.password)

    def get_all_fields_validated(self):
        return self._all_fields_validated

    def get_first_name(self):
        return self._first_name

    def get_last_name(self):
        return self._last_name

    def get_company(self):
        return self._company

    def get_email(self):
        return self._email

    def get_password(self):
        return self._password

    first_name_changed = Signal(Field)
    last_name_changed = Signal(Field)
    company_changed = Signal(Field)
    email_changed = Signal(Field)
    password_changed = Signal(Field)

    first_name = Property(Field, get_first_name, notify=first_name_changed)
    last_name = Property(Field, get_last_name, notify=last_name_changed)
    company = Property(Field, get_company, notify=company_changed)
    email = Property(Field, get_email, notify=email_changed)
    password = Property(Field, get_password, notify=password_changed)
