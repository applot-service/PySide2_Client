import QtQuick 2.15
import "../components" as Components

Rectangle {
    property Item pressedButton: {
        let defaultPage = enums.defaultPage
        if (defaultPage === creatorButton.pageType) {
            return creatorButton
        } else if (defaultPage === docsButton.pageType) {
            return docsButton
        }
    }

    onPressedButtonChanged: pageChanged(pressedButton.pageType)

    width: parent.width
    height: 50
    color: enums.colors.header

    Row {
        height: parent.height
        leftPadding: enums.spacing.std
        spacing: enums.spacing.std

        Components.HeaderButton {
            id: creatorButton
            property string pageType: enums.pageTypes.creator

            anchors.verticalCenter: parent.verticalCenter
            text: "Creator"
            buttonDown: pressedButton === this
            onClicked: pressedButton = this
        }

        Components.HeaderButton {
            id: docsButton
            property string pageType: enums.pageTypes.docs

            anchors.verticalCenter: parent.verticalCenter
            text: "Documentation"
            buttonDown: pressedButton === this
            onClicked: pressedButton = this
        }
    }
}
