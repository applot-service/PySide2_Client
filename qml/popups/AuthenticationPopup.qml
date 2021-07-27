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

    Main.Enums {
        id: enums
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
            error: AuthFields.first_name.error
            onAccepted: AuthFields.first_name.set(text)
        }

        Components.TextInput {
            id: last_name
            defaultText: "Last name"
            width: parent.width
            visible: currentAction === actions.register
            error: AuthFields.last_name.error
            onAccepted: AuthFields.last_name.set(text)
        }

        Components.TextInput {
            id: company
            defaultText: "Company"
            width: parent.width
            visible: currentAction === actions.register
            error: AuthFields.company.error
            onAccepted: AuthFields.company.set(text)
        }

        Components.TextInput {
            id: email
            defaultText: "Email"
            width: parent.width
            error: AuthFields.email.error
            errorText: fieldErrorMessage.email
            onAccepted: AuthFields.email.set(text)
        }

        Components.TextInput {
            id: password
            defaultText: "Password"
            width: parent.width
            error: AuthFields.password.error
            errorText: fieldErrorMessage.password
            onAccepted: AuthFields.password.set(text)
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
            if (!AuthFields.email.validated) {
                return false
            }
            if (!AuthFields.password.validated) {
                return false
            }
        }

        if (currentAction === actions.register) {
            if (!AuthFields.first_name.validated) {
                return false
            }
            if (!AuthFields.last_name.validated) {
                return false
            }
            if (!AuthFields.company.validated) {
                return false
            }
            if (!AuthFields.email.validated) {
                return false
            }
            if (!AuthFields.password.validated) {
                return false
            }
        }

        return true
    }

    function authPopupActionButtonPressed() {
        if (currentAction === actions.register) {
            Account.register()
        } else {
            Account.sign_in(
                        AuthFields.email.value,
                        AuthFields.password.value
                        )
        }
        authPopup.close()
    }
}
