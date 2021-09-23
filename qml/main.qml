import QtQuick 2.15
import QtQuick.Controls 2.15
import QtWebSockets 1.15

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

    WebSocket {
        id: socket
        url: "wss://oa6f4xkird.execute-api.us-east-1.amazonaws.com/Prod"
        onTextMessageReceived: {
            console.log("Received message:", message)
        }
        onStatusChanged: if (socket.status == WebSocket.Error) {
                             console.log("Error: " + socket.errorString)
                         } else if (socket.status == WebSocket.Open) {
                             socket.sendTextMessage(JSON.stringify({"action": "send_command"}))
                         } else if (socket.status == WebSocket.Closed) {
                             console.log("Socket closed")
                         }
        active: false
    }

    Timer {
        running: true
        repeat: false
        interval: 1000
        onTriggered: {
            console.log(">> STARTED SOCKET")
            socket.active = true
        }
    }
}
