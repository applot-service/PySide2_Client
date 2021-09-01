import QtQuick 2.15
import QtQuick.Controls 2.15
import "../components" as Components

Item {
    clip: true

    ScrollBar {
        id: projectsScrollBar
        anchors {
            right: parent.right
            top: parent.top
            bottom: parent.bottom
        }
    }

    GridView {
        id: projectsFlow
        property int projectCardWidth: 300
        property int flowMargins: enums.spacing.xl_max

        anchors {
            fill: parent
            margins: flowMargins
        }
        cellWidth: projectCardWidth
        cellHeight: 200
        ScrollBar.vertical: projectsScrollBar
        model: ProjectsModel
        delegate: Item {
            width: projectsFlow.projectCardWidth
            height: 200

            Rectangle {
                anchors {
                    fill: parent
                    margins: enums.spacing.std
                }

                color: enums.colors.projectCardBackground
                border.width: 1
                border.color: enums.colors.body
                radius: 6

                Components.GrandTitle {
                    id: projectTitle
                    anchors {
                        left: parent.left
                        top: parent.top
                        leftMargin: enums.spacing.max
                        topMargin: enums.spacing.l_max
                    }
                    text: model.title
                    elide: Text.ElideRight
                    maximumLineCount: 1
                }

                Components.StdText {
                    id: projectDescription
                    anchors {
                        left: parent.left
                        right: parent.right
                        top: projectTitle.bottom
                        leftMargin: enums.spacing.max
                        rightMargin: enums.spacing.std
                        topMargin: enums.spacing.std
                    }
                    text: model.description
                    elide: Text.ElideRight
                    maximumLineCount: 2
                    wrapMode: Text.WordWrap
                }

                Components.StdText {
                    id: projectLatestUpdate
                    anchors {
                        left: parent.left
                        right: parent.right
                        top: projectDescription.bottom
                        leftMargin: enums.spacing.max
                        rightMargin: enums.spacing.std
                        topMargin: enums.spacing.max
                    }
                    text: model.last_updated
                    elide: Text.ElideRight
                    maximumLineCount: 1
                }

                Row {
                    id: projectParticipants
                    anchors {
                        left: parent.left
                        right: parent.right
                        top: projectLatestUpdate.bottom
                        leftMargin: enums.spacing.max
                        rightMargin: enums.spacing.std
                        topMargin: enums.spacing.l_max
                    }
                    spacing: enums.spacing.min

                    property var iconsSize: 32

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width: projectParticipants.iconsSize
                        height: projectParticipants.iconsSize
                        radius: height / 2
                        color: Qt.rgba(Math.random(),Math.random(),Math.random(),1)
                    }

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width: projectParticipants.iconsSize
                        height: projectParticipants.iconsSize
                        radius: height / 2
                        color: Qt.rgba(Math.random(),Math.random(),Math.random(),1)
                    }

                    Rectangle {
                        anchors.verticalCenter: parent.verticalCenter
                        width: projectParticipants.iconsSize
                        height: projectParticipants.iconsSize
                        radius: height / 2
                        color: Qt.rgba(Math.random(),Math.random(),Math.random(),1)
                    }
                }
            }
        }

        add: Transition {
            ParallelAnimation {
                NumberAnimation { duration: 450; property: "scale"; from: 0.5; to: 1; easing.type: Easing.InOutCubic}
                NumberAnimation { duration: 450; property: "opacity"; from: 0; to: 1; easing.type: Easing.InOutCubic}
            }
        }

        displaced: Transition {
            id: displacedTransition
            SequentialAnimation {
                PauseAnimation {
                    duration: (displacedTransition.ViewTransition.index -
                               displacedTransition.ViewTransition.targetIndexes[0]) * 35
                }
                NumberAnimation { duration: 400; properties: "x,y"; easing.type: Easing.InOutCubic}
            }
        }

        function calculateSpacing() {
            let projectsInPageHorizontally = parseInt(projectsFlow.width / projectsFlow.projectCardWidth)
            let projectsWidth = projectsInPageHorizontally * projectsFlow.projectCardWidth
            let spacing = (projectsFlow.width - projectsWidth) / projectsInPageHorizontally
            return spacing
        }
    }
}
