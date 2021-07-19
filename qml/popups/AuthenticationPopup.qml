import QtQuick 2.15
import QtQuick.Controls 2.15
import "../" as Main
import "../components" as Components

Popup {
    id: authPopup
    width: 400
    modal: true
    focus: true
    clip: true

    QtObject {
        id: actions
        property var signIn: QtObject {
            property string title: "Sign in"
            property string alternativeAction: "Don't have an account? Register now!"
        }
        property var register: QtObject {
            property string title: "Register"
            property string alternativeAction: "Already have an account? Sign in!"
        }
    }

    property var currentAction: actions.signIn

    Main.Enums {
        id: enums
    }

    enter: Transition {
        ParallelAnimation {
            NumberAnimation { property: "opacity"; from: 0.0; to: 1.0; easing.type: Easing.InOutQuad }
            NumberAnimation { property: "scale"; from: 0.8; to: 1.0 }
        }
    }
    exit: Transition {
        ParallelAnimation {
            NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; easing.type: Easing.InOutQuad }
            NumberAnimation { property: "scale"; from: 1.0; to: 0.8; easing.type: Easing.InOutQuad }
        }
    }

    background: Rectangle {
        color: enums.colors.popup
        border.width: 1
        border.color: enums.colors.body
        radius: enums.radius.std
    }

    contentItem: Column {
        spacing: enums.spacing.std

        Components.Title {
            text: currentAction.title
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Components.TextInput {
            id: first_name
            defaultText: "First name"
            width: parent.width
            visible: currentAction === actions.register
        }

        Components.TextInput {
            id: last_name
            defaultText: "Last name"
            width: parent.width
            visible: currentAction === actions.register
        }

        Components.TextInput {
            id: company
            defaultText: "Company"
            width: parent.width
            visible: currentAction === actions.register
        }

        Components.TextInput {
            id: email
            defaultText: "Email"
            width: parent.width
        }

        Components.TextInput {
            id: password
            defaultText: "Password"
            width: parent.width
        }

        Components.FlatButton {
            text: currentAction.alternativeAction
            anchors.horizontalCenter: parent.horizontalCenter

            onClicked: {
                if (currentAction === actions.register) {
                    currentAction = actions.signIn
                } else {
                    currentAction = actions.register
                }
            }
        }

        Components.Button {
            text: currentAction.title
            anchors.right: parent.right

            onClicked: {
                if (currentAction === actions.register) {
                    register(first_name.text, last_name.text, company.text, email.text, password.text)
                } else {
                    sign_in(email.text, password.text)
                }

                authPopup.close()
            }
        }
    }

    function register(first_name, last_name, company, email, password) {
        auth.register(first_name, last_name, company, email, password)
    }

    function sign_in(email, password) {
        auth.sign_in(email, password)
    }
}
