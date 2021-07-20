import QtQuick 2.15
import QtQuick.Controls 2.15
import "../components" as Components
import "../" as Main

Rectangle {
    property string defaultText: "Default"
    property alias text: textInput.text
    property bool error: false
    signal accepted

    Main.Enums {
        id: enums
    }

    implicitWidth: 250
    implicitHeight: 34
    border.width: 1.4
    border.color: enums.colors.searchSectionBackground

    color: enums.colors.searchSectionBackground
    radius: enums.radius.std
    clip: false
    focus: true

    onErrorChanged: {
        if (error) {
            border.color = enums.colors.red
        } else {
            border.color = enums.colors.searchSectionBackground
        }
    }


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
        onActiveFocusChanged: {
            if (focus === true) {
                parent.border.color = enums.colors.blue
            } else {
                parent.border.color = enums.colors.searchSectionBackground
            }
        }
        onAccepted: parent.accepted()

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
