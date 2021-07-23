from modules.domain.managers.Authorization import Data as AuthorizationData

from PySide2.QtQml import qmlRegisterType


class InitModules:

    def __init__(self, engine):
        qmlRegisterType(AuthorizationData, 'Authorization', 1, 0, 'AuthorizationData')
        # qmlRegisterType(AccountData, 'Account', 1, 0, 'AccountData')
