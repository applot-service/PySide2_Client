import QtQuick 2.15
import QtQuick.Controls 2.15
import AuthorizationFieldsValidator 1.0

import "../" as Main
import "../components" as Components

Popup {
    id: authPopup
    width: 400
    modal: true
    focus: true
    clip: true

    AuthFieldsIsValid {
        id: authFieldsValidation
    }

    QtObject {
        id: isFieldValid

        property bool first_name
        property bool last_name
        property bool company
        property bool email
        property bool password
    }

    QtObject {
        id: responses
        property var status
        property var type
        property var message

        function set(status, type, message) {
            responses.type = type
            responses.message = message
            responses.status = status
        }

        function reset() {
            status = undefined
            type = undefined
            message = undefined
        }

        function check(type) {
            if (responses.type === type) {
                if (responses.status !== 200 || responses.status !== undefined) {
                    return true
                }
            }

            return false
        }
    }

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
            error: !isFieldValid.firstName
            onAccepted: authFieldsValidation.validate_first_name(text)
        }

        Components.TextInput {
            id: last_name
            defaultText: "Last name"
            width: parent.width
            visible: currentAction === actions.register
            error: !isFieldValid.firstName
            onAccepted: authFieldsValidation.validate_first_name(text)
        }

        Components.TextInput {
            id: company
            defaultText: "Company"
            width: parent.width
            visible: currentAction === actions.register
            error: !isFieldValid.firstName
            onAccepted: authFieldsValidation.validate_first_name(text)
        }

        Components.TextInput {
            id: email
            defaultText: "Email"
            width: parent.width
            error: !isFieldValid.email
            onAccepted: authFieldsValidation.validate_email(text)
        }

        Components.TextInput {
            id: password
            defaultText: "Password"
            width: parent.width
            error: !isFieldValid.password
            onAccepted: authFieldsValidation.validate_password(text)
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

            onClicked: authPopupActionButtonPressed()
        }
    }

    function authPopupActionButtonPressed() {
        responses.reset()

        if (currentAction === actions.register) {
            auth.register(first_name.text, last_name.text, company.text, email.text, password.text)
        } else {
            auth.sign_in(email.text, password.text)
        }
    }

    Connections {
        target: authFieldsValidation
        function onEmail_changed(value) {
            isFieldValid.email = value
        }
    }
}
