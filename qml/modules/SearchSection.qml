import QtQuick 2.15
import QtQuick.Controls 2.15

Image {
    source: "../icons/search_white_24dp.svg"
    anchors.verticalCenter: parent.verticalCenter
    opacity: 0.7
}

//Rectangle {
//    anchors {
//        verticalCenter: parent.verticalCenter
//    }

//    width: 250
//    height: 34
//    color: searchTextInput.focus ? enums.colors.searchSectionBackgroundActive
//                                 : enums.colors.searchSectionBackground
//    radius: enums.radius.std
//    clip: true

//    TextInput {
//        id: searchTextInput
//        anchors.fill: parent
//        verticalAlignment: Text.AlignVCenter
//        leftPadding: enums.spacing.std
//        rightPadding: enums.spacing.std
//        font {
//            pointSize: enums.fontSize.std
//            weight: Font.Medium
//        }
//        color: enums.colors.searchSectionTextInput
//        onAccepted: focus = false

//        Text {
//            anchors.fill: parent
//            verticalAlignment: Text.AlignVCenter
//            leftPadding: enums.spacing.std
//            rightPadding: enums.spacing.std
//            font {
//                pointSize: enums.fontSize.std
//                weight: Font.Medium
//            }
//            color: enums.colors.searchSectionText
//            text: "Search .."
//            visible: parent.text === "" && parent.focus === false
//        }
//    }

//    MouseArea {
//        id: mouseArea; anchors.fill: parent; acceptedButtons: Qt.NoButton
//        hoverEnabled: true
//        onHoveredChanged: if (hovered) mouseArea.cursorShape = Qt.IBeamCursor
//    }
//}
