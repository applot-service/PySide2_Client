from modules.domain.aggregates.Auth import Data as AuthData
from PySide2.QtQml import qmlRegisterType


class InitModules:

    def __init__(self):
        qmlRegisterType(AuthData, 'Auth', 1, 0, 'AuthData')
