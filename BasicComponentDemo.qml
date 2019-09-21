import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

ScrollView {
    //控件的implici尺寸是随内容变化的，但是我为了展示设置为了固定值
    /*implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)*/

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
                text: "DrawerShow"
                width: 120
                height: 30
                onClicked: drawer.open()
            }
            Button{
                text: "DrawerHide"
                width: 120
                height: 30
                onClicked: drawer.close()
            }
            BasicButton{
                text: "Button"
                themeColor: "green"
                textColor: "white"
            }
            BasicButton{
                text: "Basic Button"
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
            BasicComboBox{
                model: ["First", "Second", "Third"]
                themeColor: "green"
                indicatorColor: "white"
                textColor: "white"
            }
            BasicComboBox{
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
            BasicCheckBox{
                text: "Box B"
                themeColor: "blue"
                //tristate: true
                ButtonGroup.group: checkbox_group
            }
            BasicCheckBox{
                text: "Box C"
                themeColor: "transparent"
                textColor: "red"
                indicatorColor: "red"
                tristate: true
                checkState: Qt.PartiallyChecked
            }
        }

        Row{
            id:progress_row
            spacing: 10
            ProgressBar{
                width: 200; height: 10
                from: 0; to:100; value: 20
                indeterminate: true
            }
            BasicProgressBar{
                id:progress_bar1
                //from: 0; to:100; value: 20
                themeColor: "green"
                //模糊模式，即没有具体值
                indeterminate: true
            }
            BasicProgressBar{
                id: progress_bar2
                from: 0; to:100; value: 20
                themeColor: "blue"
            }
            Text {
                text: progress_bar2.value+"%"
                color: progress_bar2.themeColor
            }
        }

        Row{
            id:busy_row
            spacing: 10

            BusyIndicator{
                width: 64
                height: 64
                running: true //running时才visible
            }
            BasicBusyIndicator{
                themeColor: "orange"
            }
            BasicBusyIndicator{
                themeColor: "yellow"
            }
        }

        //BasicInputComponent.qml
        BasicInputComponent{}
    }

    //一个滑动的抽屉
    Drawer{
        id: drawer
        modal: false //fei1模态
        edge: Qt.RightEdge
        //默认点击pop外部区域就close，这里取消
        closePolicy: Popup.NoAutoClose
        width: 100
        height: parent.height
        background: Rectangle{
            color: "green"
        }
    }
}
