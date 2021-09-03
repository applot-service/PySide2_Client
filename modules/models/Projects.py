from PySide2.QtCore import (
    Qt,
    QAbstractListModel,
    QModelIndex
)


class ProjectsModel(QAbstractListModel):
    id = Qt.UserRole + 0
    title = Qt.UserRole + 1
    description = Qt.UserRole + 2
    last_updated = Qt.UserRole + 3
    participants = Qt.UserRole + 4

    def __init__(self, parent=None):
        super().__init__(parent)
        self._projects_list = []

    def rowCount(self, parent=QModelIndex()):
        return len(self._projects_list)

    def roleNames(self):
        return {
            ProjectsModel.id: b"id",
            ProjectsModel.title: b"title",
            ProjectsModel.description: b"description",
            ProjectsModel.last_updated: b"last_updated",
            ProjectsModel.participants: b"participants"
        }

    def data(self, index, role=Qt.DisplayRole):
        row = index.row()
        print("ROW IS:", row)
        if index.isValid() and 0 <= row < self.rowCount():
            if role == ProjectsModel.id:
                return self._projects_list[row].project_id
            if role == ProjectsModel.title:
                return self._projects_list[row].title
            if role == ProjectsModel.description:
                return self._projects_list[row].description
            if role == ProjectsModel.last_updated:
                return self._projects_list[row].last_updated
            if role == ProjectsModel.participants:
                return self._projects_list[row].participants

    def insertRows(self, position, rows, data, parent=QModelIndex()):
        self.beginInsertRows(parent, position, position + rows - 1)
        for i in range(rows):
            self._projects_list.insert(position, data)
        self.endInsertRows()
        return True
