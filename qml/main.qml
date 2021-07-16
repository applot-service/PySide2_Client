import QtQuick 2.15
import QtQuick.Controls 2.15
import "./popups" as Popups

ApplicationWindow {
    visible: true

    minimumWidth: 960
    minimumHeight: 640
    width: 1920
    height: 1080
    title: "Applot Editor"

    BasePage {
        id: _basePage
        anchors.fill: parent
    }

    Popups.AuthenticationPopup {
        id: authenticationPopup
        anchors.centerIn: parent
    }
}
