from PySide2.QtCore import QThreadPool

from modules.managers.AuthorizationFields import Data as AuthFieldsData
from modules.managers.Account import Data as AccountData


class Application:
    engine = None
    thread_pool = None

    def __init__(self, engine):
        self.engine = engine
        self.thread_pool = QThreadPool()

        self.auth_fields = AuthFieldsData()
        self.account = AccountData(application=self)

    def set_context_property(self):
        self.engine.rootContext().setContextProperty("AuthFields", self.auth_fields)
        self.engine.rootContext().setContextProperty("Account", self.account)

