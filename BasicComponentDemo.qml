import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

ScrollView {
    //En: The default implicit size of the control varies with the content,
    //    but I set it to a fixed value for demonstration purposes.
    //Ch: 控件的默认implicit尺寸是随内容变化的，但是我为了展示设置为了固定值
    //e.g.
    //implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    //                        implicitContentWidth + leftPadding + rightPadding)
    //implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    //                         implicitContentHeight + topPadding + bottomPadding)

    //En: In addition, I excluded mirrored (which may represent right-to-left)
    //Ch: 此外，我排除了mirrored这种情况（他可能是表示的右到左）

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
            //En: CheckBox sets tristate to three-state mode, as detailed in the document.
            //Ch: CheckBox 设置tristate后为三态模式，详见文档
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

        //发现一个问题，qml中放了busyindicattor，或者progressbar设置indeterminate，
        //类似这些动态效果，在我的电脑上缩小窗口过程中会有闪烁
        Row{
            id:progress_row
            spacing: 10
            //En: When ProgressBar sets indeterminate, it waits for an indeterminate time,
            //    similar to BusyIndicator
            //Ch: ProgressBar设置indeterminate后为时间不明确的等待，类似BusyIndicator
            ProgressBar{
                width: 200; height: 10
                from: 0; to:100; value: 20
                indeterminate: true
            }
            BasicProgressBar{
                id:progress_bar1
                //from: 0; to:100; value: 20
                themeColor: "green"
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

        Row{
            id:spinbox_row
            spacing: 10
            //参考文档示例里代码
            SpinBox{
                width: 120
                height: 30
                //默认范围[0,99]，步进1
                from: -100
                to: 100
                value: -100
                stepSize: 2
            }
            SpinBox {
                id: spinbox2
                width: 150
                height: 30
                from: 0
                to: items.length - 1
                value: 1 // "Medium"
                property var items: ["Small", "Medium", "Large"]

                validator: RegExpValidator {
                    //js的正则对象
                    //参数一为正则表达式
                    //参数二为可选字符，包含属性 "g"、"i" 和 "m"，
                    //     分别用于指定全局匹配、区分大小写的匹配和多行匹配
                    regExp: new RegExp("(Small|Medium|Large)", "i")
                }

                textFromValue: function(value) {
                    return items[value];
                }
                valueFromText: function(text) {
                    for (var i = 0; i < items.length; ++i) {
                        if (items[i].toLowerCase().indexOf(text.toLowerCase()) === 0)
                            return i
                    }
                    return sb.value
                }
            }
            SpinBox{
                id: spinbox3
                width: 150
                height: 30
                from: 0
                to: 100*100
                value: 1111
                stepSize: 1
                editable: true
                //wrap为true则上下按钮设置是循环设置范围内值的
                wrap: true
                property int decimals: 2
                validator: DoubleValidator {
                    decimals: spinbox3.decimals
                    bottom: Math.min(spinbox3.from, spinbox3.to)
                    top:  Math.max(spinbox3.from, spinbox3.to)
                }
                //loale为格式化数据和数字，见control
                //如果想使用js的函数作为回调函数，可以看下这部分的源码
                textFromValue: function(value, locale) {
                    return Number(value / 100).toLocaleString(locale, 'f', spinbox3.decimals)
                }

                valueFromText: function(text, locale) {
                    return Number.fromLocaleString(locale, text) * 100
                }
            }
            BasicSpinBox{
                from: 0
                to: 100
                value: 10
                stepSize: 1
                editable: true
            }
            BasicSpinBox{
                from: 0
                to: 100
                value: 10
                stepSize: 1
                //editable: true
                borderVisible: false
                //borderColor: "darkCyan"
                textColor: "white"
                btnNormalColor: "darkCyan"
                bgNormalColor: "skyblue"
                bgFocusColor: "blue"
                indicatorNormalColor: "white"
                indicatorDisableColor: "gray"
            }
        }

        Row{
            id: slider_row
            spacing: 10
            //在实际应用中，也可以关联scrollbar，鼠标滚动之类的
            Slider{
                height: 200
                width: 20
                //默认范围[0.0,1.0]
                //stepSize: 默认为0.0
                //默认Horizontal
                orientation: Qt.Vertical
                //如果setp not defined，那么每次decrease（减）和increase（增）0.1
            }
            Column{
                spacing: 10
                Slider{
                    id: slider_2
                    width: 200
                    height: 20
                    from: 0
                    to: 100
                    value: 30
                    stepSize: 1
                    orientation: Qt.Horizontal
                    onValueChanged: {
                        slider_3.value=value
                    }
                }
                Slider{
                    id: slider_3
                    width: 200
                    height: 20
                    from: 0
                    to: 100
                    value: 30
                    stepSize: 1
                    orientation: Qt.Horizontal

                    // mirror镜像反转只有水平的，所以竖向的我只写了一个
                    // LayoutMirroring.enabled设置为ture启用镜像
                    LayoutMirroring.enabled:true
                    // childrenInherit属性设置为true，那么该项目的所有子项目都会启用镜像
                    LayoutMirroring.childrenInherit: true
                    onValueChanged: {
                        slider_2.value=value
                    }
                }
            }
            BasicSlider{
                height: 200
                orientation: Qt.Vertical
            }
            Column{
                spacing: 10
                BasicSlider{
                    width: 200
                    orientation: Qt.Horizontal
                }
                BasicSlider{
                    width: 200
                    orientation: Qt.Horizontal
                    LayoutMirroring.enabled:true
                    LayoutMirroring.childrenInherit: true

                    handleBorderColor: "black"
                    handleNormalColor: "white"
                    handleHoverColor: "gray"
                    handlePressColor: "black"
                    completeColor: "black"
                    incompleteColor: "gray"
                }
            }
        }

        Row{
            id:scrollbar_row
            spacing: 10

            //用ScrollView来展示ScrollBar
            ScrollView{
                id: scrollview_1
                width: 200
                height: 200
                contentWidth: 500
                //contentHeight: 500
                background: Rectangle{
                    border.color: "black"
                    border.width: 1
                }
                padding: 1
                ScrollBar.vertical: ScrollBar {
                    parent: scrollview_1
                    x: scrollview_1.mirrored ? 0 : scrollview_1.width - width
                    y: scrollview_1.topPadding
                    //可以判断下另一边的scrollbar，减去其高度避免重叠
                    height: scrollview_1.availableHeight
                    active: scrollview_1.ScrollBar.horizontal.active
                    policy: ScrollBar.AlwaysOn //默认asneeded需要操作时才显示
                    //默认是可以拖动来交互的
                    //interactive: true
                }

                ScrollBar.horizontal: ScrollBar {
                    parent: scrollview_1
                    x: scrollview_1.leftPadding
                    y: scrollview_1.height - height
                    //可以判断下另一边的scrollbar，减去其宽度避免重叠
                    width: scrollview_1.availableWidth
                    active: scrollview_1.ScrollBar.vertical.active
                    policy: ScrollBar.AsNeeded
                }
            }

            ScrollView{
                id: scrollview_2
                width: 200
                height: 200
                contentWidth: 500
                //contentHeight: 500
                background: Rectangle{
                    border.color: "black"
                    border.width: 1
                }
                padding: 1
                ScrollBar.vertical: BasicScrollBar {
                    parent: scrollview_2
                    //这里有1是为了防止踩再background的border上
                    x: scrollview_2.mirrored ? 1 : scrollview_2.width - width-1
                    y: scrollview_2.topPadding
                    height: scrollview_2.availableHeight
                    active: scrollview_2.ScrollBar.horizontal.active
                    policy: ScrollBar.AlwaysOn //因为每超出范围，所以设置让他显示
                    handleNormalColor: "orange"
                }

                ScrollBar.horizontal: BasicScrollBar {
                    parent: scrollview_2
                    x: scrollview_2.leftPadding
                    y: scrollview_2.height - height-1
                    width: scrollview_2.availableWidth
                    active: scrollview_2.ScrollBar.vertical.active
                    policy: ScrollBar.AsNeeded
                    handleNormalColor: "orange"
                }
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
