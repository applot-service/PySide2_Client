import QtQuick 2.15

QtObject {

    property var colors: QtObject {
        property color section: "#e6e6e6"

        property color title: "#f0f0f0"

        property color header: "#242424"
        property color body: "#111111"
        property color popup: "#4d4d4d"
        property color popupBackground: "#60000000"

        property color buttonTextPressed: "#f0f0f0"
        property color buttonTextNotPressed: "#888888"
        property color buttonBackgroundPressed: "#333333"
        property color buttonBackgroundNotPressed: "transparent"

        property color stdButtonBackgroundPressed: "#333333"
        property color stdButtonBackgroundNotPressed: "#2f89fe"

        property color flatButtonBackgroundPressed: "#f0f0f0"
        property color flatButtonBackgroundNotPressed: "#2f89fe"

        property color searchSectionBackground: "#333333"
        property color searchSectionText: "#838383"
        property color searchSectionTextInput: "#f0f0f0"
    }

    property var spacing: QtObject {
        property real min: 6
        property real std: 12
        property real max: 18
    }

    property var radius: QtObject {
        property real min: 3
        property real std: 6
        property real max: 9
    }

    property var fontSize: QtObject {
        property real min: 10
        property real std: 12
        property real max: 16
    }

    property var pageTypes: QtObject {
        property string creator: "CREATOR"
        property string docs: "DOCS"
    }

    property string defaultPage: "DOCS"
}
