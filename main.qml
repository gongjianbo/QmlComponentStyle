import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

ApplicationWindow{
    id:root
    visible: true
    width: 720
    height: 500
    title: qsTr("Qml Component Style: by Gong Jian Bo")

    Loader{
        id: root_loader
        anchors.fill: parent
        source: "qrc:/BasicComponentDemo.qml"
    }

    menuBar: MenuBar{
        Menu{
            title: "Demo List"
            Action{
                text: "Basic"
                onTriggered: root_loader.setSource("qrc:/BasicComponentDemo.qml")
            }
            Action{
                text: "Custom"
                onTriggered: root_loader.setSource("qrc:/CustomComponentDemo.qml")
            }
        }
    }
}
