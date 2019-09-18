import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

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

            Button{
                text: "Button"
                width: 90
                height: 30
            }
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

            ComboBox{
                width: 120
                height: 30
                model: ["First", "Second", "Third"]
            }
            BaseComboBox{
                model: ["First", "Second", "Third"]
                themeColor: "green"
                indicatorColor: "white"
                textColor: "white"
            }
            BaseComboBox{
                model: ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
                themeColor: "blue"
                indicatorColor: "yellow"
                textColor: "yellow"
            }            
        }

        Row{
            id:checkbox_row
            spacing: 10

            ButtonGroup{
                id:checkbox_group
            }
            CheckBox{
                width: 90
                height: 30
                text: "Box A"
                checked: true
                ButtonGroup.group: checkbox_group
            }
            BaseCheckBox{
                text: "Box B"
                themeColor: "blue"
                tristate: true
                ButtonGroup.group: checkbox_group
            }
            BaseCheckBox{
                text: "Box C"
                themeColor: "transparent"
                textColor: "red"
                indicatorColor: "red"
                tristate: true
                checkState: Qt.PartiallyChecked
            }
        }
    }
}
