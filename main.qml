import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

Window {
    id:root
    visible: true
    width: 720
    height: 500
    title: qsTr("Qml Component Style")

    Loader{
        anchors.fill: parent
        source: "qrc:/BaseComponentDemo.qml"
    }
}
