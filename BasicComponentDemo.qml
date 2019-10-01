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
            id:gradientbutton_row
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
            GradientButton{
                text: "Button"
                themeColor: "green"
                textColor: "white"
            }
            GradientButton{
                text: "Basic Button"
                icon.source: "qrc:/fire.png"
                themeColor: "red"
                textColor: "white"
            }
        }

        Row{
            id:gradientcombobox_row
            spacing: 10

            ComboBox{
                width: 120
                height: 30
                model: ["First", "Second", "Third"]
            }
            GradientComboBox{
                model: ["First", "Second", "Third"]
                themeColor: "green"
                indicatorColor: "white"
                textColor: "white"
            }
            GradientComboBox{
                model: ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
                themeColor: "blue"
                indicatorColor: "yellow"
                textColor: "yellow"
            }
        }

        Row{
            id:gradientcheckbox_row
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
            GradientCheckBox{
                text: "Box B"
                themeColor: "blue"
                //tristate: true
                ButtonGroup.group: checkbox_group
            }
            GradientCheckBox{
                text: "Box C"
                themeColor: "red"
                textColor: "white"
                indicatorColor: "blue"
                tristate: true
                checkState: Qt.PartiallyChecked
            }
        }

        Row{
            id:button_row
            spacing: 10

            Button{
                text: "Button"
                width: 120
                height: 30
            }
            BasicButton{
                text: "Button"
                textColor: "white"
                backgroundColor: "green"
            }
            BasicButton{
                text: "Basic Button"
                icon.source: "qrc:/fire.png"
                textColor: "white"
                backgroundColor: "red"
                _textHoverColor: "cyan"
                _bgHoverColor: "purple"
                radius: 3
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
                textColor: "white"
                indicatorColor: "white"
                backgroundColor: "deepskyblue"
            }
            BasicComboBox{
                model: ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
                textColor: "white"
                indicatorColor: "white"
                backgroundColor: "green"
                radius: 3
            }
        }

        //发现一个问题，qml中放了busyindicattor，或者progressbar设置indeterminate，
        //类似这些动态效果，在我的电脑上缩小窗口过程中会有闪烁
        Row{
            id:checkbox_row
            spacing: 10

            ButtonGroup{
                id:checkbox_group2
            }
            CheckBox{
                width: 90
                height: 30
                text: "Box A"
                checked: true
                ButtonGroup.group: checkbox_group2
            }
            BasicCheckBox{
                text: "Box B"
                textColor: "white"
                backgroundColor: "orange"
                ButtonGroup.group: checkbox_group2
            }
            BasicCheckBox{
                text: "Box C"
                textColor: "cyan"
                backgroundColor: "purple"
                indicatorColor: "cyan"
                tristate: true
                checkState: Qt.PartiallyChecked
                radius: 3
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
                themeColor: "purple"
            }
        }

        Row{
            id:label_row
            spacing: 10

            Label{
                //Label继承自Text，而Text是支持Html样式的
                text: "<u>Label</u>"
            }
            BasicLabel{
                underlineVisible: true
                normalColor: "red"
                hoverColor: "blue"
                text: "Label"
            }
            BasicLabel{
                text: "Label"
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
