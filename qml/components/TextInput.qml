import QtQuick 2.15
import QtQuick.Controls 2.15
import "../components" as Components
import "../" as Main

Rectangle {
    property string defaultText: "Default"
    property alias text: textInput.text

    Main.Enums {
        id: enums
    }

    implicitWidth: 250
    implicitHeight: 34
    color: enums.colors.searchSectionBackground
    radius: enums.radius.std
    clip: true

    TextInput {
        id: textInput
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
            text: defaultText
            visible: parent.text === "" && parent.focus === false
        }
    }

    MouseArea {
        id: mouseArea; anchors.fill: parent; acceptedButtons: Qt.NoButton
        hoverEnabled: true
        onEntered: mouseArea.cursorShape = Qt.IBeamCursor
    }
}
