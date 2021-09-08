from PySide2.QtCore import QObject, Signal, Slot
from ApplotLibs.DataStructures.MessageBus.Commands import Projects as ProjectsCommands


class Manager(QObject):
    def __init__(self, application):
        QObject.__init__(self)
        self.message_bus = application.message_bus
        token = None

    @Slot()
    def pull_projects(self):  # Pulling all projects from server
        pull_comand = ProjectsCommands.Pull(
            token=self.token
        )
        self.message_bus.post(pull_comand)

    @Slot()
    def create_project(self):
        create_project_command = ProjectsCommands.CreateProject(
            token=self.token
        )
        self.message_bus.post(create_project_command)


# ///////////////////////
# def _get_projects():
#     pass
#
# def _create_project():
#     return Project.BaseProject.create_empty_project()
#
#
# class Manager(QObject):
#     def __init__(self, application):
#         QObject.__init__(self)
#         self.thread_pool = application.thread_pool
#         self.projects_model = application.projects_model
#
#         self._adding_project_in_progress = False
#
#     # Slots
#     @Slot()
#     def pull_projects(self):  # Pulling all projects from server
#         worker = Worker(_get_projects)
#         worker.signals.result.connect(self.pull_projects_result)
#         worker.signals.finished.connect(self.pull_projects_finished)
#         worker.signals.error.connect(self._error)
#
#         self.thread_pool.start(worker)
#
#     @Slot()
#     def create_project(self):
#         self._adding_project_in_progress = True
#         self.adding_project_in_progress_changed.emit(
#             self._adding_project_in_progress
#         )
#         worker = Worker(_create_project)
#         worker.signals.result.connect(self.create_project_result)
#         worker.signals.finished.connect(self.create_project_finished)
#         worker.signals.error.connect(self._error)
#
#         self.thread_pool.start(worker)
#
#     # Result Handlers
#     def pull_projects_result(self, projects):
#         self._projects_model.clear()
#         if not projects:
#             return
#         for project in projects:
#             self.projects_model.insertRows(position=0, rows=1, data=project)
#
#     def create_project_result(self, project):
#         self.projects_model.insertRows(position=0, rows=1, data=project)
#
#     # Finished Handlers
#     def pull_projects_finished(self):
#         print("FINISHED:")
#
#     def create_project_finished(self):
#         self._adding_project_in_progress = False
#         self.adding_project_in_progress_changed.emit(
#             self._adding_project_in_progress
#         )
#
#     # Error Handlers
#     def _error(self, err):
#         print("ERROR:", err)
