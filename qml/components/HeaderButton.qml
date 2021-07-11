import QtQuick 2.12
import QtQuick.Controls 2.12
import "../" as Main

Button {
    id: button
    property var buttonDown: false

    text: qsTr("Button")
    height: 34

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
        color: button.buttonDown ? enums.colors.buttonTextPressed
                              : enums.colors.buttonTextNotPressed
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 40
        color: button.buttonDown ? enums.colors.buttonBackgroundPressed
                              : enums.colors.buttonBackgroundNotPressed
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
