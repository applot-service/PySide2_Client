import QtQuick 2.15
import QtQuick.Controls 2.15

import "./popups" as Popups

ApplicationWindow {
    visible: true

    minimumWidth: 960
    minimumHeight: 640
    width: 1280
    height: 720
    title: "Applot Editor"

    BasePage {
        id: _basePage
        anchors.fill: parent
    }
}
