import QtQuick 2.15
import QtQuick.Controls 2.15
import "./pages/" as Pages

ApplicationWindow {
    visible: true

    minimumWidth: 960
    minimumHeight: 640
    width: 1920
    height: 1080
    title: "Applot Editor"

    Pages.Start {
        id: _start
    }
}
