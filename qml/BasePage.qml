import QtQuick 2.15
import QtQuick.Controls 2.15
import "./components" as Components
import "./modules" as Modules

Page {
    id: basePage
    signal pageChanged(string page)

    Enums {
        id: enums
    }

    header: Modules.NavigationHeader {
        id: navigationHeader
    }

    Modules.NavigationBody {
        id: navigationBody
        anchors.fill: parent
    }
}