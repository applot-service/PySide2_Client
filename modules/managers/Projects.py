from PySide2.QtCore import QObject, Signal, Slot, Property

from modules.utilities.threading import Worker


def _get_projects():
    pass


class Manager(QObject):
    def __init__(self, application):
        QObject.__init__(self)
        self.thread_pool = application.thread_pool
        self.token = application.account.token
        self.projects_model = application.projects_model

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
        # worker = Worker(self._create_project)
        # worker.signals.result.connect(self.create_project_result)
        # worker.signals.finished.connect(self.create_project_finished)
        # worker.signals.error.connect(self.create_project_error)
        #
        # self.thread_pool.start(worker)
        self._create_project()

    # Workers
    def _create_project(self):
        from datetime import datetime
        data = {
            "title": datetime.now().strftime("%H:%M:%S")
        }
        print("DATA:", data)
        self.projects_model.insertRows(position=0, rows=1, data=data)

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

    def create_project_result(self):
        pass

    def create_project_finished(self):
        print("FINISHED:")

    def create_project_error(self, err):
        print("ERROR:", err)
