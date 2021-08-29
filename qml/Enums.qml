import QtQuick 2.15

QtObject {

    property var colors: QtObject {
        property color section: "#e6e6e6"

        property color title: "#f0f0f0"

        property color header: "#242424"
        property color body: "#242424"
        property color light_body: "#333333"
        property color popup: "#4d4d4d"
        property color popupBackground: "#60000000"

        property color buttonTextPressed: "#f0f0f0"
        property color buttonTextNotPressed: "#888888"
        property color buttonBackgroundPressed: "#4d4d4d"
        property color buttonBackgroundNotPressed: "transparent"

        property color stdButtonBackgroundPressed: "#4d4d4d"
        property color stdButtonBackgroundNotPressed: "#2f89fe"

        property color flatButtonBackgroundPressed: "#f0f0f0"
        property color flatButtonBackgroundNotPressed: "#2f89fe"

        property color searchSectionBackground: "#333333"
        property color searchSectionBackgroundActive: "#4d4d4d"
        property color searchSectionText: "#b3b3b3"
        property color searchSectionTextInput: "#f0f0f0"

        property color projectCardBackground: "#4d4d4d"

        property color blue: "#2f89fe"
        property color red: "#FF5C4A"
    }

    property var spacing: QtObject {
        property real min: 6
        property real std: 12
        property real max: 18
        property real l_max: 24
        property real xl_max: 30
        property real xxl_max: 36
        property real huge: 42
    }

    property var radius: QtObject {
        property real min: 3
        property real std: 6
        property real max: 9
    }

    property var fontSize: QtObject {
        property real min: 9
        property real std: 11
        property real max: 15
    }

    property var pageTypes: QtObject {
        property string creator: "CREATOR"
        property string docs: "DOCS"
    }

    property string defaultPage: "CREATOR"
}
