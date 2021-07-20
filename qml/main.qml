import QtQuick 2.15
import QtQuick.Controls 2.15
import Authorization 1.0

import "./popups" as Popups

ApplicationWindow {
    visible: true

    minimumWidth: 960
    minimumHeight: 640
    width: 1280
    height: 720
    title: "Applot Editor"

    AuthorizationData {
        id: authorization
    }

    BasePage {
        id: _basePage
        anchors.fill: parent
    }

    Popups.AuthenticationPopup {
        id: authenticationPopup
        anchors.centerIn: parent
    }
}
