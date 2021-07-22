import QtQuick 2.15
import QtQuick.Controls 2.15
import AuthorizationPopupFields 1.0

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

    AuthPopupFields {
        id: authFields
    }
    QtObject {
        id: hasError

        property bool first_name: authFields.first_name_has_error
        property bool last_name: authFields.last_name_has_error
        property bool company: authFields.company_has_error
        property bool email: authFields.email_has_error
        property bool password: authFields.password_has_error

        property bool all_fields: authFields.all_fields_have_error
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
            error: hasError.first_name
            onAccepted: authFields.validate_first_name(text)
        }

        Components.TextInput {
            id: last_name
            defaultText: "Last name"
            width: parent.width
            visible: currentAction === actions.register
            error: hasError.last_name
            onAccepted: authFields.validate_last_name(text)
        }

        Components.TextInput {
            id: company
            defaultText: "Company"
            width: parent.width
            visible: currentAction === actions.register
            error: hasError.company
            onAccepted: authFields.validate_company(text)
        }

        Components.TextInput {
            id: email
            defaultText: "Email"
            width: parent.width
            error: hasError.email
            errorText: fieldErrorMessage.email
            onAccepted: authFields.validate_email(text)
        }

        Components.TextInput {
            id: password
            defaultText: "Password"
            width: parent.width
            error: hasError.password
            errorText: fieldErrorMessage.password
            onAccepted: authFields.validate_password(text)
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
            enabled: !hasError.all_fields

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
}
