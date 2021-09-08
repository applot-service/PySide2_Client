from PySide2.QtCore import QObject, Signal, Slot, Property


class Data(QObject):
    def __init__(self, application):
        QObject.__init__(self)
        self._adding_project_in_progress = False

    def get_adding_project_in_progress(self):
        return self._adding_project_in_progress

    adding_project_in_progress_changed = Signal(bool)

    adding_project_in_progress = Property(
        bool, get_adding_project_in_progress,
        notify=adding_project_in_progress_changed
    )
