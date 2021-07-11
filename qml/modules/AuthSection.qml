import QtQuick 2.15
import "../components" as Components

Item {
    width: signInButton.width
    height: parent.height

    Components.HeaderButton {
        id: signInButton
        property string pageType: enums.pageTypes.docs

        anchors.centerIn: parent
        text: "Sign In"
        buttonDown: pressedButton === this
        Component.onCompleted: {
            signInButton.contentItem.color = enums.colors.buttonTextPressed
        }
    }
}
