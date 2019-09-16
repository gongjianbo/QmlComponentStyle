import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    id:root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Column{
        anchors{
            left: parent.left
            top: parent.top
            margins: 10
        }
        spacing: 10

        Row{
            id:button_row
            spacing: 10

            BaseButton{
                text: "Button"
                themeColor: "green"
                textColor: "white"
            }
            BaseButton{
                text: "Base Button"
                icon.source: "qrc:/fire.png"
                themeColor: "red"
                textColor: "white"
            }
        }

        Row{
            id:combobox_row
            spacing: 10

            BaseComboBox{
                model: ["First", "Second", "Third"]
                themeColor: "green"
                indicatorColor: "white"
                textColor: "white"
            }
            BaseComboBox{
                model: ["First", "Second", "Third"]
                themeColor: "red"
                indicatorColor: "yellow"
                textColor: "yellow"
            }
        }
    }
}
