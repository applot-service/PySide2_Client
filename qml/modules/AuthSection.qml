import QtQuick 2.15
import "../components" as Components

Row {
    height: parent.height
    spacing: enums.spacing.min
    opacity: 0.7

    Image {
        source: "../icons/account_circle_white_24dp.svg"
        anchors.verticalCenter: parent.verticalCenter

        MouseArea {
            anchors.fill: parent
            onClicked: {
                AccountManager.sign_out()
            }
        }
    }

    Text {
        anchors.verticalCenter: parent.verticalCenter
        text: AccountData.email
        font {
            pointSize: enums.fontSize.std
            weight: Font.Medium
        }
        color: "white"
    }
}
