import QtQuick 2.15
import "../" as Main

Text {

    Main.Enums {
        id: enums
    }

    font {
        pointSize: 16
        weight: Font.Medium
    }

    topPadding: 10
    leftPadding: 10
    color: enums.colors.title
}
