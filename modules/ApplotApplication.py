from modules.domain.managers.Authorization import Data as AuthorizationData
from modules.domain.managers.AuthorizationPopup import FieldsErrors as AuthPopupFieldsErrors
from modules.domain.managers.AuthorizationPopup import FieldsValues as AuthPopupFieldsValues

from PySide2.QtQml import qmlRegisterType


class InitModules:

    def __init__(self, engine):
        qmlRegisterType(AuthorizationData, 'Authorization', 1, 0, 'AuthorizationData')
        qmlRegisterType(AuthPopupFieldsErrors, 'AuthorizationPopupFieldsErrors', 1, 0, 'AuthPopupFieldsErrors')
        qmlRegisterType(AuthPopupFieldsValues, 'AuthorizationPopupFieldsValues', 1, 0, 'AuthPopupFieldsValues')