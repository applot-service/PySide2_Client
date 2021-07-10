import QtQuick 2.15
import QtGraphicalEffects 1.15
import "../" as Main

Item {
    property real radius: 10

    anchors.centerIn: parent

    Main.Enums {
        id: enums
    }

    Rectangle {
        id: frameRectangle
        anchors {
            fill: parent
            margins: 0
        }
        radius: parent.radius

        LinearGradient {
            anchors.fill: parent
            source: parent
            cached: true
            start: Qt.point(parent.width * 0.7, 0)
            end: Qt.point(parent.width * 0.4, parent.height)
            gradient: Gradient {
                GradientStop { position: 0.0; color: enums.colors.frameLight }
                GradientStop { position: 1.0; color: enums.colors.frameDark }
            }
        }
    }

    DropShadow {
        anchors.fill: frameRectangle
        cached: true
        horizontalOffset: 2
        verticalOffset: 2
        radius: 9
        samples: 16
        color: enums.colors.frameShadow
        source: frameRectangle
    }
}
