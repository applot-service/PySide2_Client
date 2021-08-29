from PySide2.QtCore import QThreadPool, QSettings

from modules.managers.AuthorizationFields import Manager as AuthFieldsManager
from modules.managers.Account import Manager as AccountManager
from modules.managers.Projects import Manager as ProjectsManager

from modules.models.Projects import ProjectsModel


class Application:
    engine = None
    thread_pool = None

    def __init__(self, engine):
        self.engine = engine
        self.thread_pool = QThreadPool()
        self.settings = QSettings("Applot", "applot.tech")

        # Models
        self.projects_model = ProjectsModel()

        # Managers
        self.auth_fields = AuthFieldsManager()
        self.account = AccountManager(application=self)
        self.projects = ProjectsManager(application=self)

    def set_context_property(self):
        # Models
        self.engine.rootContext().setContextProperty("ProjectsModel", self.projects_model)

        # Managers
        self.engine.rootContext().setContextProperty("AuthFields", self.auth_fields)
        self.engine.rootContext().setContextProperty("Account", self.account)
        self.engine.rootContext().setContextProperty("Projects", self.projects)
