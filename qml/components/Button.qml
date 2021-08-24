import QtQuick 2.12
import QtQuick.Controls 2.12
import "../" as Main

Button {
    id: button

    text: qsTr("Button")
    height: 34
    opacity: enabled ? 1.0 : 0.4

    property color backgroundColor: enums.colors.stdButtonBackgroundNotPressed

    contentItem: Text {
        text: button.text
        padding: enums.spacing.min
        font {
            pointSize: enums.fontSize.std
            weight: Font.Medium
        }
        color: enums.colors.buttonTextPressed
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 40
        radius: enums.radius.std
        color: backgroundColor
    }

    onDownChanged: {
        if (down) {
            backgroundColor = enums.colors.stdButtonBackgroundPressed
        } else {
            backgroundColor = enums.colors.stdButtonBackgroundNotPressed
        }
    }

    onHoveredChanged: {
        if (hovered) {
            mouseArea.cursorShape = Qt.PointingHandCursor
            backgroundColor = Qt.lighter(backgroundColor, 1.1)
        } else {
            backgroundColor = enums.colors.stdButtonBackgroundNotPressed
        }

    }
    MouseArea { id: mouseArea; anchors.fill: parent; acceptedButtons: Qt.NoButton }
}
