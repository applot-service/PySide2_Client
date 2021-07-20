import QtQuick 2.12
import QtQuick.Controls 2.12
import "../" as Main

Button {
    id: button

    text: qsTr("Button")
    height: 34
    opacity: enabled ? 1.0 : 0.4

    Main.Enums {
        id: enums
    }

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
        color: button.down ? enums.colors.stdButtonBackgroundPressed
                              : enums.colors.stdButtonBackgroundNotPressed
        border.color: enums.colors.buttonBackgroundPressed
        border.width: 0
        radius: enums.radius.std
    }

    onHoveredChanged: {
        if (hovered) {
            mouseArea.cursorShape = Qt.PointingHandCursor
            button.background.border.width = 2
        } else {
            button.background.border.width = 0
        }

    }
    MouseArea { id: mouseArea; anchors.fill: parent; acceptedButtons: Qt.NoButton }
}
