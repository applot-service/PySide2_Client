import QtQuick 2.15
import "../components" as Components
import "../modules" as Modules

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

    Rectangle {
        width: parent.width
        height: 1
        anchors.bottom: parent.bottom
        color: enums.colors.light_body
    }

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

    Row {
        height: parent.height
        anchors{
            right: parent.right
        }
        rightPadding: enums.spacing.xl_max
        spacing: enums.spacing.max

        Modules.SearchSection {
            id: searchSection
        }

        Modules.AuthSection {
            id: authSection
        }
    }
}
