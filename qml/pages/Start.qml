import QtQuick 2.15
import "../components" as Components
import "../" as Main

Item {
    anchors.fill: parent

    property real minSpacing: 6
    property real stdSpacing: 12
    property real maxSpacing: 18


    Main.Enums {
        id: enums
    }

    Components.Frame {
        id: frame

        width: 860
        height: 640


        Item {
            id: recentProjectsItem
            anchors {
                top: parent.top
                right: parent.right
                bottom: parent.bottom
                margins: stdSpacing
            }
            width: frame.width * 0.58

            Components.Title {
                id: recentProjectsTitle
                text: qsTr("Recent Projects")
            }

            Rectangle {
                id: recentProjectsRec
                anchors {
                    top: recentProjectsTitle.bottom
                    right: parent.right
                    bottom: parent.bottom
                    margins: stdSpacing
                }
                width: frame.width * 0.58
                color: enums.colors.section
                radius: frame.radius
            }
        }

        Item {
            id: createProjectItem
            anchors {
                top: parent.top
                left: parent.left
                right: recentProjectsItem.left
                margins: stdSpacing
            }
            height: frame.height * 0.5 - stdSpacing

            Components.Title {
                id: createProjectTitle
                text: qsTr("Create Project")
            }

            Rectangle {
                id: createProjectRec
                anchors {
                    top: createProjectTitle.bottom
                    left: parent.left
                    right: parent.right
                    margins: stdSpacing
                }
                height: createProjectItem.height - createProjectTitle.height
                color: enums.colors.section
                radius: frame.radius
            }
        }



        Rectangle {
            id: accountRec
            anchors {
                top: createProjectRec.bottom
                left: parent.left
                right: recentProjectsRec.left
                bottom: parent.bottom
                margins: stdSpacing
            }
            height: frame.height * 0.5 - stdSpacing
            color: enums.colors.section
            radius: frame.radius

            Components.Title {
                text: qsTr("Account")
            }
        }
    }
}
