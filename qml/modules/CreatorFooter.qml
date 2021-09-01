import QtQuick 2.15
import "../components" as Components
import "../modules" as Modules

Rectangle {
    width: parent.width
    height: 65
    color: enums.colors.header

    Row {
        height: 50
        anchors.bottom: parent.bottom
        rightPadding: enums.spacing.huge
        spacing: enums.spacing.l_max

        Components.Button {
            property string pageType: enums.pageTypes.creator

            anchors.verticalCenter: parent.verticalCenter
            text: "New project"
        }
    }
}
