import QtQuick 2.15
import QtQuick.Controls 2.15

import "./pages" as Pages

ApplicationWindow {
    visible: true

    minimumWidth: 960
    minimumHeight: 640
    width: 1280
    height: 720
    title: "Applot Editor"
    color: "#111111"

    Enums {
        id: enums
    }

    BasePage {
        id: _basePage
        anchors.fill: parent
    }

    Pages.AuthPage {
        id: authPage
        anchors.fill: parent

        property var token: Account.token
        onTokenChanged: {
            if (token) {
                authPage.visible = false
                authPage.state = "fields"
            } else {
                authPage.visible = true
                authPage.state = "fields"
            }
        }
    }
}
