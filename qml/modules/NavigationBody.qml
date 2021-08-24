import QtQuick 2.15
import QtQuick.Controls 2.15
import "../components" as Components
import "../" as Main
import "../pages" as Pages


Rectangle {
    color: enums.colors.body

    Connections {
        target: basePage

        function onPageChanged(currentPage){
            setPage(currentPage)
        }
    }

    function setPage(currentPage) {
        if (currentPage === creatorPage.pageType) {
            navigationSwipeView.currentIndex = creatorPage.itemIndex
        } else if (currentPage === docsPage.pageType) {
            navigationSwipeView.currentIndex = docsPage.itemIndex
        }
    }

    SwipeView {
        id: navigationSwipeView
        anchors.fill: parent
        currentIndex: setPage(enums.defaultPage)
        interactive: false

        Pages.CreatorPage {
            id: creatorPage
            property string pageType: enums.pageTypes.creator
            property var itemIndex: SwipeView.index
        }

        Item {
            id: docsPage
            property string pageType: enums.pageTypes.docs
            property var itemIndex: SwipeView.index

            Text {
                anchors.centerIn: parent
                text: qsTr("DOCS")
                color: "white"
            }
        }
    }
}


