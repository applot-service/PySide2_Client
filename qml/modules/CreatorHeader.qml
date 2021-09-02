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
        leftPadding: enums.spacing.huge
        spacing: enums.spacing.l_max

        Image {
            source: "../icons/arrow_back_white_24dp.svg"
            anchors.verticalCenter: parent.verticalCenter
            opacity: 0.25
        }

        Components.Title {
            text: qsTr("Projects /")
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    Row {
        height: 50
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        rightPadding: enums.spacing.huge
        spacing: enums.spacing.min

        Components.BusyIndicator {
            id: busyIndicator
            anchors.verticalCenter: parent.verticalCenter
            visible: Projects.adding_project_in_progress
        }

        Components.Button {
            property string pageType: enums.pageTypes.creator

            anchors.verticalCenter: parent.verticalCenter
            text: "New project"
            enabled: !Projects.adding_project_in_progress
            onClicked: Projects.create_project()
        }
    }
}
