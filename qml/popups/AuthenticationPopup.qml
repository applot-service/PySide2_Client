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

    Main.Enums {
        id: enums
    }

    AuthFieldsIsValid {
        id: authFieldsValidation
    }

    QtObject {
        id: hasError

        property bool first_name: false
        property bool last_name: false
        property bool company: false
        property bool email: false
        property bool password: false
    }

    QtObject {
        id: fieldErrorMessage

        property string email: qsTr("Your email is invalid")
        property string password: qsTr("Your password must be at least 10 characters long, have a special character and an uppercase and lowercase letter.")
    }

    property var currentAction: actions.signIn
    property bool hasError
    property string currentErrorMessage

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
            error: hasError.first_name
            onAccepted: authFieldsValidation.validate_first_name(text)
        }

        Components.TextInput {
            id: last_name
            defaultText: "Last name"
            width: parent.width
            visible: currentAction === actions.register
            error: hasError.last_name
            onAccepted: authFieldsValidation.validate_last_name(text)
        }

        Components.TextInput {
            id: company
            defaultText: "Company"
            width: parent.width
            visible: currentAction === actions.register
            error: hasError.company
            onAccepted: authFieldsValidation.validate_company(text)
        }

        Components.TextInput {
            id: email
            defaultText: "Email"
            width: parent.width
            error: hasError.email
            errorText: fieldErrorMessage.email
            onAccepted: authFieldsValidation.validate_email(text)
        }

        Components.TextInput {
            id: password
            defaultText: "Password"
            width: parent.width
            error: hasError.password
            errorText: fieldErrorMessage.password
            onAccepted: authFieldsValidation.validate_password(text)
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
            enabled: false

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
        function onFirst_name_changed(has_error) {
            hasError.first_name = has_error
        }

        function onLast_name_changed(has_error) {
            hasError.last_name = has_error
        }

        function onCompany_changed(has_error) {
            hasError.company = has_error
        }

        function onEmail_changed(has_error) {
            hasError.email = has_error
        }

        function onPassword_changed(has_error) {
            hasError.password = has_error
        }
    }
}


//    QtObject {
//        id: responses
//        property var status
//        property var type
//        property var message

//        function set(status, type, message) {
//            responses.type = type
//            responses.message = message
//            responses.status = status
//        }

//        function reset() {
//            status = undefined
//            type = undefined
//            message = undefined
//        }

//        function check(type) {
//            if (responses.type === type) {
//                if (responses.status !== 200 || responses.status !== undefined) {
//                    return true
//                }
//            }

//            return false
//        }
//    }
