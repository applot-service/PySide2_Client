from PySide2.QtCore import QThreadPool, QSettings

from modules.Validators.AuthorizationFields import Manager as AuthFieldsValidator
from modules.Managers.Account import Manager as AccountManager
from modules.Managers.Projects import Manager as ProjectsManager

from modules.Data.Account import Data as AccountData
from modules.Data.Projects import Data as ProjectsData
from modules.Models.Projects import ProjectsModel
from modules.Domain.Actions.settings import SettingsActions
from modules.MessageBus import Client as MessageBusClient


class Application:
    engine = None
    thread_pool = None

    def __init__(self, engine):
        self.engine = engine
        self.thread_pool = QThreadPool()
        self.settings = SettingsActions(QSettings("Applot", "applot.tech"))

        # Event Driven Message Bus
        self.message_bus = MessageBusClient()

        # Models
        self.projects_model = ProjectsModel()

        # Data
        self.account_data = AccountData(application=self)
        self.projects_data = ProjectsData(application=self)

        # Validators
        self.auth_fields_validator = AuthFieldsValidator()

        # Managers
        self.account_manager = AccountManager(application=self)
        self.projects_manager = ProjectsManager(application=self)

        # Setting services
        self.message_bus.enable_event_handling(application=self)

    def set_context_property(self):
        # Models
        self.engine.rootContext().setContextProperty("ProjectsModel", self.projects_model)

        # Data
        self.engine.rootContext().setContextProperty("AccountData", self.account_data)
        self.engine.rootContext().setContextProperty("ProjectsData", self.projects_data)

        # Managers
        self.engine.rootContext().setContextProperty("AuthFields", self.auth_fields_validator)
        self.engine.rootContext().setContextProperty("AccountManager", self.account_manager)
        self.engine.rootContext().setContextProperty("ProjectsManager", self.projects_manager)
