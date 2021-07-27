from modules.domain.managers.AuthFields import Data as AuthorizationData
from modules.domain.managers.Account import Data as AccountData


from PySide2.QtQml import qmlRegisterType


class InitModules:

    def __init__(self, engine):
        qmlRegisterType(AuthorizationData, 'Authorization', 1, 0, 'AuthorizationData')
        qmlRegisterType(AccountData, 'Account', 1, 0, 'AccountData')
