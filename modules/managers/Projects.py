from PySide2.QtCore import QObject, Signal, Slot, Property, QAbstractListModel
from modules.utilities.threading import Worker


def _get_projects(token):
    pass


def _create_project():
    pass


class ProjectsModel(QAbstractListModel):
    def __init__(self):
        QAbstractListModel.__init__(self)
        self._projects_list = []

    def rowCount(self, parent):
        return len(self._projects_list)

    def data(self, index, role):
        pass

    def repopulate(self, source: dict):
        return self


class Manager(QObject):
    def __init__(self, application):
        QObject.__init__(self)
        self.application = application
        self._projects_model = ProjectsModel()

    def get_projects_model(self):
        return self._projects_model

    projects_changed = Signal(ProjectsModel)
    projects = Property(ProjectsModel, get_projects_model, notify=projects_changed)

    # Slots
    @Slot(str)
    def get_projects(self):
        token = self.application.account.token  # TODO: implement
        worker = Worker(_get_projects, token=token)
        worker.signals.result.connect(self.get_projects_result)
        worker.signals.finished.connect(self.get_projects_finished)
        worker.signals.error.connect(self.get_projects_error)

        self.application.thread_pool.start(worker)

    @Slot(str)
    def create_project(self):
        worker = Worker(_create_project)
        worker.signals.result.connect(self.create_project_result)
        worker.signals.finished.connect(self.create_project_finished)
        worker.signals.error.connect(self.create_project_error)

        self.application.thread_pool.start(worker)

    # Handlers
    def get_projects_result(self, projects):
        self._projects_model = None
        if projects:
            self._projects_model = ProjectsModel().repopulate(projects)

    def get_projects_finished(self):
        print("FINISHED:")

    def get_projects_error(self, err):
        print("ERROR:", err)

    def create_project_result(self):
        print("REGISTER:")

    def create_project_finished(self):
        print("FINISHED:")

    def create_project_error(self, err):
        print("ERROR:", err)
