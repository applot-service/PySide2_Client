import QtQuick 2.15
import QtQuick.Controls 2.15
import "../components" as Components
import "../" as Main

Rectangle {
    property string defaultText: "Default"
    property alias text: textInput.text
    property alias errorText: textInputError.text
    property bool error: false
    signal accepted

    onErrorChanged: handling_ErrorOrFocus()

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
        onActiveFocusChanged: handling_ErrorOrFocus()
        onAccepted: {
            focus = false
            parent.accepted()
        }

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

    Text {
        id: textInputError
        anchors {
            top: parent.bottom
            topMargin: 1
            left: parent.left
            right: parent.right
        }

        verticalAlignment: Text.AlignVCenter
        leftPadding: enums.spacing.std
        rightPadding: enums.spacing.std
        font {
            pointSize: enums.fontSize.min
            weight: Font.Medium
        }
        wrapMode: Text.WordWrap
        color: enums.colors.searchSectionTextInput
        visible: error
    }

    MouseArea {
        id: mouseArea; anchors.fill: parent; acceptedButtons: Qt.NoButton
        hoverEnabled: true
        onEntered: mouseArea.cursorShape = Qt.IBeamCursor
    }

    function handling_ErrorOrFocus() {
        if (textInput.focus === true) {
            border.color = enums.colors.blue
            return
        }

        if (textInput.text.length == 0) {
            border.color = enums.colors.searchSectionBackground
            return
        }

        if (error) {
            border.color = enums.colors.red
            return
        } else {
            border.color = enums.colors.searchSectionBackground
            return
        }
    }
}
