import QtQuick 2.15
import QtQuick.Controls 2.15
import "../modules" as Modules

Page {
    header: Modules.CreatorHeader {}

    Rectangle {
        anchors.fill: parent
        color: enums.colors.body

        Modules.ProjectsFlow {
            anchors.fill: parent
        }
    }
}
