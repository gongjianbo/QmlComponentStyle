import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    BaseButton{
        text: "Base Button"
        iconSource: "qrc:/fire.png"
        themeColor: "red"
        textColor: "white"
        onClicked: {
            console.log(text,'clicked')
        }
    }
}
