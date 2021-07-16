import QtQuick 2.12
import QtQuick.Controls 2.12
import "../" as Main

Button {
    id: button

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
        color: button.buttonDown ? enums.colors.flatButtonBackgroundPressed
                                 : enums.colors.flatButtonBackgroundNotPressed
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 40
        color: "transparent"
    }

    onHoveredChanged: {
        if (hovered) {
            mouseArea.cursorShape = Qt.PointingHandCursor
        }
    }
    MouseArea { id: mouseArea; anchors.fill: parent; acceptedButtons: Qt.NoButton }
}
