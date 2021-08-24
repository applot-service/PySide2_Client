from PySide2.QtCore import QObject, Signal, Slot, Property
from modules.domain.aggregates import ProjectsList
from modules.utilities.threading import Worker


def _get_project(project_id):
    pass


def _create_project():
    pass


class Manager(QObject):
    def __init__(self, application):
        QObject.__init__(self)
        self.application = application
        self._projects = None

    def get_projects(self):
        return self._projects

    projects_changed = Signal(str)
    projects = Property(str, get_projects, notify=projects_changed)

    # Slots
    @Slot(str)
    def get_project(self, project_id: str):
        worker = Worker(_get_project, project_id=project_id)
        worker.signals.result.connect(self.get_project_result)
        worker.signals.finished.connect(self.get_project_finished)
        worker.signals.error.connect(self.get_project_error)

        self.application.thread_pool.start(worker)

    @Slot(str)
    def create_project(self, project_id: str):
        worker = Worker(_create_project)
        worker.signals.result.connect(self.create_project_result)
        worker.signals.finished.connect(self.create_project_finished)
        worker.signals.error.connect(self.create_project_error)

        self.application.thread_pool.start(worker)

    # Handlers
    def get_project_result(self, account):
        self._account = None
        if account:
            self._account = account

    def get_project_finished(self):
        print("FINISHED:")

    def get_project_error(self, err):
        print("ERROR:", err)

    def create_project_result(self):
        print("REGISTER:")

    def create_project_finished(self):
        print("FINISHED:")

    def create_project_error(self, err):
        print("ERROR:", err)
