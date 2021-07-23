import QtQuick 2.15
import QtQuick.Controls 2.15
import Authorization 1.0

import "../" as Main
import "../components" as Components

Popup {
    id: authPopup
    width: 400
    modal: true
    focus: true
    clip: true

    Main.Enums {
        id: enums
    }

    AuthorizationData {
        id: authorizationData
    }

    QtObject {
        id: fieldErrorMessage

        property string email: qsTr("Your email is invalid")
        property string password: qsTr("Your password must be at least 10 characters long, have a special character and an uppercase and lowercase letter.")
    }

    property var currentAction: actions.signIn
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
        spacing: enums.spacing.l_max

        Components.Title {
            text: currentAction.title
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Components.TextInput {
            id: first_name
            defaultText: "First name"
            width: parent.width
            visible: currentAction === actions.register
            error: authorizationData.first_name.error
            onAccepted: authorizationData.first_name.set(text)
        }

        Components.TextInput {
            id: last_name
            defaultText: "Last name"
            width: parent.width
            visible: currentAction === actions.register
            error: authorizationData.last_name.error
            onAccepted: authorizationData.last_name.set(text)
        }

        Components.TextInput {
            id: company
            defaultText: "Company"
            width: parent.width
            visible: currentAction === actions.register
            error: authorizationData.company.error
            onAccepted: authorizationData.company.set(text)
        }

        Components.TextInput {
            id: email
            defaultText: "Email"
            width: parent.width
            error: authorizationData.email.error
            errorText: fieldErrorMessage.email
            onAccepted: authorizationData.email.set(text)
        }

        Components.TextInput {
            id: password
            defaultText: "Password"
            width: parent.width
            error: authorizationData.password.error
            errorText: fieldErrorMessage.password
            onAccepted: authorizationData.password.set(text)
        }

        Item {
            width: parent.width
            height: -5
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
            enabled: checkIfButtonEnabled()

            onClicked: authPopupActionButtonPressed()
        }
    }

    function checkIfButtonEnabled() {

        if (currentAction === actions.signIn) {
            if (!authorizationData.email.validated) {
                return false
            }
            if (!authorizationData.password.validated) {
                return false
            }
        }

        if (currentAction === actions.register) {
            if (!authorizationData.first_name.validated) {
                return false
            }
            if (!authorizationData.last_name.validated) {
                return false
            }
            if (!authorizationData.company.validated) {
                return false
            }
            if (!authorizationData.email.validated) {
                return false
            }
            if (!authorizationData.password.validated) {
                return false
            }
        }

        return true
    }

    function authPopupActionButtonPressed() {
        if (currentAction === actions.register) {
            authorizationData.register()
        } else {
            authorizationData.sign_in()
        }
        authPopup.close()
    }
}
