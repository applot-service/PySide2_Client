import QtQuick 2.15
import QtQuick.Controls 2.15
import "../components" as Components
import "../" as Main

Rectangle {
    anchors {
        verticalCenter: parent.verticalCenter
    }

    Main.Enums {
        id: enums
    }

    width: 250
    height: 34
    color: enums.colors.searchSectionBackground
    radius: enums.radius.std
    clip: true

    TextInput {
        anchors.fill: parent
        verticalAlignment: Text.AlignVCenter
        leftPadding: enums.spacing.std
        rightPadding: enums.spacing.std
        font {
            pointSize: enums.fontSize.std
            weight: Font.Medium
        }
        color: enums.colors.searchSectionTextInput

        Text {
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            leftPadding: enums.spacing.std
            rightPadding: enums.spacing.std
            font {
                pointSize: enums.fontSize.std
                weight: Font.Medium
            }
            color: enums.colors.searchSectionText
            text: "Search .."
            visible: parent.text === "" && parent.focus === false
        }
    }

    MouseArea {
        id: mouseArea; anchors.fill: parent; acceptedButtons: Qt.NoButton
        hoverEnabled: true
        onHoveredChanged: if (hovered) mouseArea.cursorShape = Qt.IBeamCursor
    }
}
