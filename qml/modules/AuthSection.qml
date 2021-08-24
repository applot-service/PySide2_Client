import QtQuick 2.15
import "../components" as Components

Row {
    height: parent.height
    spacing: enums.spacing.min

    Rectangle {
        anchors.verticalCenter: parent.verticalCenter
        width: 28
        height: 28
        radius: height / 2
        color: "black"
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        text: qsTr("Username")
        font {
            pointSize: enums.fontSize.std
            weight: Font.Medium
        }
        color: "white"
    }

//    Components.HeaderButton {
//        id: signInButton
//        property string pageType: enums.pageTypes.docs

//        anchors.centerIn: parent
//        text: "Sign In"
//        onClicked: {
//            authenticationPopup.open()
//            authenticationPopup.forceActiveFocus()
//        }
//        Component.onCompleted: {
//            signInButton.contentItem.color = enums.colors.buttonTextPressed
//        }
//    }
}
