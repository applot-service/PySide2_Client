from modules.domain.aggregates.Authorization import Data as AuthorizationData
from modules.domain.aggregates.AuthorizationFields import IsValid as AuthFieldsIsValid
from PySide2.QtQml import qmlRegisterType


class InitModules:

    def __init__(self):
        qmlRegisterType(AuthorizationData, 'Authorization', 1, 0, 'AuthorizationData')
        qmlRegisterType(AuthFieldsIsValid, 'AuthorizationFieldsValidator', 1, 0, 'AuthFieldsIsValid')
