import QtQuick 2.15
import QtQuick.Controls 2.15
import "../" as Main
import "../components" as Components

Popup {
    id: authPopup
    anchors.centerIn: parent
    modal: true
    focus: true
    clip: true

    QtObject {
        id: actions
        property string signIn: "Sign in"
        property string register: "Register"
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
        implicitWidth: 400
        height: contentItem.height + (contentItem.spacing * 2)
        color: enums.colors.popup
        border.width: 1
        border.color: enums.colors.body
        radius: enums.radius.std
    }

    contentItem: Column {
        spacing: enums.spacing.std

        Components.Title {
            text: currentAction
            leftPadding: enums.spacing.std
        }

        Components.TextInput {
            defaultText: "First name"
            width: parent.width
            visible: currentAction == actions.register
        }

        Components.TextInput {
            defaultText: "Last name"
            width: parent.width
            visible: currentAction == actions.register
        }

        Components.TextInput {
            defaultText: "Company"
            width: parent.width
            visible: currentAction == actions.register
        }

        Components.TextInput {
            defaultText: "Email"
            width: parent.width
        }

        Components.TextInput {
            defaultText: "Password"
            width: parent.width
        }

        Components.Button {
            text: currentAction

            onClicked: currentAction = actions.register
        }
    }
}
