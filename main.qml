import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: root
    visible: true
    width: 900
    height: 720
    title: "Qml Component Style: by Gong Jian Bo"

    Loader {
        id: root_loader
        anchors.fill: parent
        source: "qrc:/CustomComponentDemo.qml"
    }

    menuBar: MenuBar {
        Menu {
            title: "Demo List"
            Action {
                text: "Basic"
                onTriggered: root_loader.setSource("qrc:/BasicComponentDemo.qml")
            }
            Action {
                text: "Custom"
                onTriggered: root_loader.setSource("qrc:/CustomComponentDemo.qml")
            }
        }
    }
}
