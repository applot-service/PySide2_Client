from PySide2.QtCore import QObject, Signal, Slot, Property
from modules.domain.entities import Project
from modules.utilities.threading import Worker


def _get_projects():
    pass


def _create_project():
    return Project.BaseProject.create_empty_project()


class Manager(QObject):
    def __init__(self, application):
        QObject.__init__(self)
        self.thread_pool = application.thread_pool
        self.token = application.account.token
        self.projects_model = application.projects_model

        self._adding_project_in_progress = False

    def get__adding_project_in_progress(self):
        return self._adding_project_in_progress

    adding_project_in_progress_changed = Signal(bool)

    adding_project_in_progress = Property(
        bool, get__adding_project_in_progress,
        notify=adding_project_in_progress_changed
    )

    # Slots
    @Slot()
    def pull_projects(self):  # Pulling all projects from server
        worker = Worker(_get_projects)
        worker.signals.result.connect(self.pull_projects_result)
        worker.signals.finished.connect(self.pull_projects_finished)
        worker.signals.error.connect(self.pull_projects_error)

        self.thread_pool.start(worker)

    @Slot()
    def create_project(self):
        self._adding_project_in_progress = True
        self.adding_project_in_progress_changed.emit(
            self._adding_project_in_progress
        )
        worker = Worker(_create_project)
        worker.signals.result.connect(self.create_project_result)
        worker.signals.finished.connect(self.create_project_finished)
        worker.signals.error.connect(self.create_project_error)

        self.thread_pool.start(worker)

    # Handlers
    def pull_projects_result(self, projects):
        self._projects_model.clear()
        if not projects:
            return
        for project in projects:
            self.projects_model.insertRows(position=0, rows=1, data=project)

    def pull_projects_finished(self):
        print("FINISHED:")

    def pull_projects_error(self, err):
        print("ERROR:", err)

    def create_project_result(self, project):
        self.projects_model.insertRows(position=0, rows=1, data=project)

    def create_project_finished(self):
        self._adding_project_in_progress = False
        self.adding_project_in_progress_changed.emit(
            self._adding_project_in_progress
        )

    def create_project_error(self, err):
        print("ERROR:", err)
