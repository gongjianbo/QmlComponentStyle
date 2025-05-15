import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import "./BasicComponent"

// 展示基础组件的自定义
// 控件的默认implicit尺寸是随内容变化的，但是我有些地方设置为了固定值
// 例如：
// implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
//                         implicitContentWidth + leftPadding + rightPadding)
// implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
//                          implicitContentHeight + topPadding + bottomPadding)
// 此外，我排除了mirrored这种情况（表示右到左这种书写习惯）
ScrollView {
    id: control

    Column {
        anchors{
            left: parent.left
            top: parent.top
            margins: 10
        }
        spacing: 10

        Row {
            id: menu_row
            spacing: 10
            Text {
                width: 90
                height: 30
                renderType: Text.NativeRendering
                text: "Menu:"
            }
            Button {
                text: "A Menu"
                width: 120
                height: 30
                onClicked: menu_default.open()
                Menu {
                    id: menu_default
                    y: parent.height
                    Action { text: "A" }
                    Action { text: "B" }
                }
            }
            // menubar通过row来组织menu
            // menu通过listview来组织menuitem
            BasicButton {
                text: "B Menu"
                width: 120
                height: 30
                backgroundColor: "gray"
                onClicked: menu_style.open()
                BasicMenu {
                    id: menu_style
                    y: parent.height
                    Action { text: "A" }
                    Action { text: "B" }
                }
            }
        }

        MenuBar {
            width: 600
            // 使用MenuBarItem来添加图标
            // MenuBarItem{}
            Menu {
                title: "MenuA"
                Action { text: "A"; checkable: true; checked: true }
                Action { text: "B"; checkable: true; icon.source: "qrc:/fire.png" }
                MenuSeparator {}
                // 使用MenuItem来添加图标
                MenuItem {
                    text: "C"
                    icon.source: "qrc:/fire.png"
                }
                // 有下级菜单的还不知道怎么设置icon
                Menu {
                    title: "D"
                    Action { text: "A" }
                    Action { text: "B" }
                }
            }
            Menu {
                title: "Menu Test"
                Action { text: "A" }
                Action { text: "B" }
            }
        }

        BasicMenuBar {
            width: 600
            height: 30
            BasicMenu {
                title: "MenuA"
                Action { text: "A"; checkable: true; checked: true }
                Action { text: "B"; checkable: true; }
                BasicMenuSeparator {}
                BasicMenuItem {
                    text: "C"
                }
                BasicMenu {
                    title: "D"
                    Action { text: "A" }
                    Action { text: "B" }
                }
            }
            BasicMenu {
                title: "Menu Test"
                Action { text: "A" }
                Action { text: "B" }
            }
        }

        TabBar {
            width: 600
            background: Rectangle { color: palette.button }
            // tabbar默认平均分宽度
            TabButton { width: 120; text: "Tab"; icon.source: "qrc:/fire.png" }
            TabButton { width: 120; text: "Button" }
            TabButton { width: 120; text: "GongJianBo" }
        }

        BasicTabBar {
            width: 600
            // tabbar默认平均分宽度
            BasicTabButton { width: 120; text: "Tab"; icon.source: "qrc:/fire.png" }
            BasicTabButton { width: 120; text: "Button" }
            BasicTabButton { width: 120; text: "1992" }
        }

        ToolBar {
            width: 600
            RowLayout {
                layoutDirection: Qt.LeftToRight
                ToolButton { text: "Tool"; icon.source: "qrc:/fire.png" }
                ToolButton { text: "Button" }
                ToolSeparator {}
                ToolButton { text: "GongJianBo" }
            }
        }

        BasicToolBar {
            width: 600
            RowLayout {
                layoutDirection: Qt.LeftToRight
                BasicToolButton { text: "Tool"; icon.source: "qrc:/fire.png" }
                BasicToolButton { text: "Button" }
                BasicToolSeparator {}
                BasicToolButton { icon.source: "qrc:/fire.png" }
            }
        }

        Row {
            id: test_row
            spacing: 10
            Text {
                width: 90
                height: 30
                renderType: Text.NativeRendering
                text: "Test:"
            }
            Button {
                text: "DrawerShow"
                width: 120
                height: 30
                onClicked: drawer.open()
            }
            Button {
                text: "DrawerHide"
                width: 120
                height: 30
                onClicked: drawer.close()
            }

            Button {
                text: "Dialog"
                width: 120
                height: 30
                onClicked: basic_dialog.open()

                BasicDialog { id: basic_dialog }
            }
        }

        Row {
            id: gradientbutton_row
            spacing: 10
            Text {
                width: 90
                height: 30
                renderType: Text.NativeRendering
                text: "Button:"
            }
            GradientButton {
                text: "Button"
                themeColor: "green"
                textColor: "white"
            }
            GradientButton {
                text: "Basic Button"
                icon.source: "qrc:/fire.png"
                themeColor: "red"
                textColor: "white"
            }
            GradientButton {
                width: 200
                text: "Basic Button"
                icon.source: "qrc:/fire.png"
                themeColor: "red"
                textColor: "white"
            }
        }

        Row {
            id: gradientcombobox_row
            spacing: 10
            Text {
                width: 90
                height: 30
                renderType: Text.NativeRendering
                text: "ComboBox:"
            }
            ComboBox {
                editable: true
                width: 120
                height: 30
                model: ["First", "Second", "Third"]
            }
            GradientComboBox {
                editable: true
                model: ["First", "Second", "Third"]
                themeColor: "green"
                indicatorColor: "white"
                textColor: "white"
                // onEditTextChanged: { console.log(editText); }
            }
            GradientComboBox {
                model: ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
                themeColor: "blue"
                indicatorColor: "yellow"
                textColor: "yellow"
            }
        }

        Row {
            id: gradientcheckbox_row
            spacing: 10
            Text {
                width: 90
                height: 30
                renderType: Text.NativeRendering
                text: "CheckBox:"
            }
            ButtonGroup {
                id: checkbox_group
            }
            // CheckBox 设置tristate后为三态模式，详见文档
            CheckBox {
                width: 90
                height: 30
                text: "Box A"
                checked: true
                ButtonGroup.group: checkbox_group
            }
            GradientCheckBox {
                height: 30
                text: "Box B"
                themeColor: "blue"
                // tristate: true
                ButtonGroup.group: checkbox_group
            }
            GradientCheckBox {
                height: 30
                text: "Box C"
                themeColor: "red"
                textColor: "white"
                icon.color: "yellow"
                tristate: true
                checkState: Qt.PartiallyChecked
            }
        }

        Row {
            id: button_row
            spacing: 10
            Text {
                width: 90
                height: 30
                renderType: Text.NativeRendering
                text: "Button:"
            }
            Button {
                text: "Button"
                width: 120
                height: 30
            }
            BasicButton {
                width: 50
                text: "Button"
            }
            BasicButton {
                text: "Button"
                textColor: "white"
                themeColor: "green"
            }
            BasicButton {
                text: "Basic Button"
                icon.source: "qrc:/fire.png"
                textColor: "white"
                radius: 4
                backgroundColor: (pressed || checked)
                                 ? Qt.darker("purple")
                                 : (hovered || highlighted)
                                   ? Qt.lighter("darkCyan")
                                   : "red"
            }
            BasicButton {
                width: 200
                text: "Basic Button"
                icon.source: "qrc:/fire.png"
                textColor: "white"
                themeColor: "red"
                icon.color: "yellow"
                radius: 4
            }
        }

        Row {
            id: combobox_row
            spacing: 10
            Text {
                width: 90
                height: 30
                renderType: Text.NativeRendering
                text: "ComboBox:"
            }
            ComboBox {
                editable: true
                width: 120
                height: 30
                model: ["First", "Second", "Third"]
            }
            BasicComboBox {
                width: 80
                editable: true
                model: ["First", "Second", "Third"]
                indicatorWidth: 20
            }
            BasicComboBox {
                editable: true
                model: ["First", "Second", "Third"]
                textColor: "white"
                themeColor: "deepskyblue"
                // onEditTextChanged: { console.log(editText); }
            }
            BasicComboBox {
                model: ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
                textColor: "white"
                radius: 4
                indicatorSource: "qrc:/updown.png"
                themeColor: "green"
                itemNormalColor: "skyblue"
                itemHighlightColor: "darkCyan"
                showFunc: function(value) {
                    return String('No.[%1]').arg(value);
                }
            }
            BasicComboBox {
                width: 80
                model: ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
                textColor: "white"
                radius: 4
                indicatorSource: "qrc:/updown.png"
                themeColor: "green"
                itemNormalColor: "skyblue"
                itemHighlightColor: "darkCyan"
                showFunc: function(value) {
                    // 65是大写A
                    return String.fromCharCode(Number(value) + 64);
                }
            }
            BasicComboBox {
                width: 80
                // 测试空model
            }
        }

        Row {
            id: checkbox_row
            spacing: 10
            Text {
                width: 90
                height: 30
                renderType: Text.NativeRendering
                text: "CheckBox:"
            }
            ButtonGroup {
                id: checkbox_group2
            }
            CheckBox {
                width: 90
                height: 30
                text: "Box A"
                checked: true
                ButtonGroup.group: checkbox_group2
            }
            BasicCheckBox {
                text: "Box B"
                ButtonGroup.group: checkbox_group2
            }
            BasicCheckBox {
                text: "Box C"
                textColor: "green"
                themeColor: "purple"
                tristate: true
                checkState: Qt.PartiallyChecked
                indicatorRadius: 4
                indicatorBorderWidth: 2
                indicatorButtonColor: "green"
            }
            BasicCheckBox {
                text: "Box D"
                textColor: "red"
                themeColor: "purple"
            }
        }

        Row {
            id: radiobutton_row
            spacing: 10
            Text {
                width: 90
                height: 30
                renderType: Text.NativeRendering
                text: "RadioButton:"
            }
            // 默认情况下，单选按钮是自动排他的。属于同一父项的单选按钮中随时只能检查一个按钮。
            // 对于不共享公共父级的单选按钮，可以使用ButtonGroup来管理排他性。
            Row {
                spacing: 10
                RadioButton {
                    height: 30
                    checked: true
                    text: "A"
                }
                RadioButton {
                    height: 30
                    text: "B"
                }
            }
            Row {
                spacing: 10
                BasicRadioButton {
                    checked: true
                    text: "First"
                }
                BasicRadioButton {
                    text: "Second"
                    textColor: "purple"
                    themeColor: "green"
                    indicatorBorderWidth: 4
                }
                BasicRadioButton {
                    text: "Third"
                    themeColor: "blue"
                    indicatorRadius: 0
                }
            }
        }

        Row {
            id: switch_row
            spacing: 10
            Text {
                width: 90
                height: 30
                renderType: Text.NativeRendering
                text: "SwitchButton:"
            }
            Switch {
                text: "Switch"
                width: 120
                height: 30
            }
            BasicSwitch {
                text: "Gong"
                width: 120
                height: 30
                checked: true
            }
            BasicSwitch {
                text: "1992"
                width: 120
                height: 30
                themeColor: "green"
                indicatorBorderWidth: 2
                indicatorVerticalPadding: 0
            }
        }

        Row {
            id: delaybutton_row
            spacing: 10
            Text {
                width: 90
                height: 30
                renderType: Text.NativeRendering
                text: "DelayButton:"
            }

            DelayButton {
                text: "Delay"
                width: 120
                height: 30
                onActivated: console.log("delay active", delay)
                onCheckedChanged: console.log("delay state", checked)
            }
            BasicDelayButton {
                text: "GongJianBo"
            }
            BasicDelayButton {
                text: "1992"
                delay: 1000
                backgroundColor: "purple"
                maskBackgroundColor: "green"
                radius: 4
            }
        }

        Row {
            id: tumbler_row
            spacing: 10
            Text {
                width: 90
                height: 30
                renderType: Text.NativeRendering
                text: "Tumbler:"
            }
            Tumbler {
                width: 60
                height: 160
                model: ['AM','PM']
            }
            Tumbler {
                id: tumbler
                width: 60
                height: 160
                model: 12
                visibleItemCount: 5
            }
            BasicTumbler {
                width: 60
                height: 160
                model: 60
                visibleItemCount: 7
            }
            BasicTumbler {
                width: 60
                height: 160
                model: ["gong", "jian", "bo", "1992"]
                normalTextColor: "cyan"
                selectedTextColor: "white"
                backgroundGradient: Gradient {
                    GradientStop { position: 0.0; color: Qt.lighter("purple") }
                    GradientStop { position: 0.5; color: Qt.darker("purple") }
                    GradientStop { position: 1.0; color: Qt.lighter("purple") }
                }
            }
        }

        // qml中放了busyindicattor，或者progressbar设置indeterminate，
        // 类似这种有动画效果的绘制，在部分电脑上缩小窗口过程中会有闪烁
        Row {
            id: progress_row
            spacing: 10
            Text {
                width: 90
                height: 30
                renderType: Text.NativeRendering
                text: "ProgressBar:"
            }
            ProgressBar {
                width: 200; height: 10
                from: 0; to:100; value: 20
                indeterminate: true
            }
            BasicProgressBar {
                // from: 0; to:100; value: 20
                indeterminate: true
            }
            BasicProgressBar {
                from: 0; to:100; value: 20
                themeColor: "green"
                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.right
                    anchors.leftMargin: 10
                    text: parent.value + "%"
                    color: parent.themeColor
                }
            }
        }

        Row {
            id: busy_row
            spacing: 10
            Text {
                width: 90
                height: 30
                renderType: Text.NativeRendering
                text: "BusyIndicator:"
            }
            BusyIndicator {
                width: 86
                height: 86
                running: true // running时才visible
            }
            BasicBusyIndicator {
            }
            BasicBusyIndicator {
                themeColor: "purple"
            }
        }

        Row {
            id: label_row
            spacing: 10
            Text {
                width: 90
                height: 30
                renderType: Text.NativeRendering
                text: "Label:"
            }
            Label {
                text: "Label"
                font.underline: true
            }
            Label {
                // Label继承自Text，而Text是支持Html样式的
                text: "<u>Label</u>"
            }
            Label {
                text: '<a href="https://www.baidu.com/">Baidu</a>'
                onLinkActivated: function(link) {
                    Qt.openUrlExternally(link)
                }
            }
            BasicLabel {
                text: "Basic"
                font.underline: true
            }
            BasicLabel {
                text: "<u>Basic</u>"
            }
            BasicLabel {
                text: '<a href="https://www.baidu.com/">Baidu</a>'
                onLinkActivated: function(link) {
                    Qt.openUrlExternally(link)
                }
            }
        }

        Row {
            id: spinbox_row
            spacing: 10
            Text {
                width: 90
                height: 30
                renderType: Text.NativeRendering
                text: "SpinBox:"
            }
            // 参考文档里的三个示例
            SpinBox {
                width: 120
                height: 30
                // 默认范围[0,99]，步进1
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
                    // js的正则对象
                    // 参数一为正则表达式
                    // 参数二为可选字符，包含属性 "g"、"i" 和 "m"，
                    //      分别用于指定全局匹配、区分大小写的匹配和多行匹配
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
            SpinBox {
                id: spinbox3
                width: 150
                height: 30
                from: 0
                to: 100 * 100
                value: 1111
                stepSize: 1
                editable: true
                // wrap为true则上下按钮设置是循环设置范围内值的
                wrap: true
                property int decimals: 2
                validator: DoubleValidator {
                    decimals: spinbox3.decimals
                    bottom: Math.min(spinbox3.from, spinbox3.to)
                    top:  Math.max(spinbox3.from, spinbox3.to)
                }
                // locale为格式化数据和数字，见control
                // 如果想使用js的函数作为回调函数，可以看下这部分的源码
                textFromValue: function(value, locale) {
                    return Number(value / 100).toLocaleString(locale, 'f', spinbox3.decimals)
                }
                valueFromText: function(text, locale) {
                    return Number.fromLocaleString(locale, text) * 100
                }
            }
            BasicSpinBox {
                from: 0
                to: 100
                value: 10
                stepSize: 1
                editable: true
            }
            BasicSpinBox {
                from: 0
                to: 100
                value: 10
                stepSize: 1
                // editable: true
                borderWidth: 0
                textColor: "white"
                buttonNormalColor: "darkCyan"
                indicatorNormalColor: "white"
                indicatorDisableColor: "gray"
                backgroundNormalColor: "skyblue"
                backgroundFocusColor: Qt.darker("skyblue")
            }
        }

        Row {
            id: slider_row
            spacing: 10
            Text {
                width: 90
                height: 30
                renderType: Text.NativeRendering
                text: "Slider:"
            }
            // 在实际应用中，也可以关联scrollbar，鼠标滚动之类的
            Slider {
                height: 200
                width: 20
                // 默认Horizontal横向
                orientation: Qt.Vertical
            }
            Column {
                spacing: 10
                // 两个联动的slider
                Slider {
                    id: slider_2
                    width: 200
                    height: 20
                    from: 0
                    to: 100
                    value: 30
                    stepSize: 1
                    orientation: Qt.Horizontal
                    onValueChanged: {
                        slider_3.value = value
                    }
                }
                Slider {
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
                    LayoutMirroring.enabled: true
                    // childrenInherit属性设置为true，那么该项目的所有子项目都会启用镜像
                    LayoutMirroring.childrenInherit: true
                    onValueChanged: {
                        slider_2.value = value
                    }
                }
            }
            BasicSlider {
                height: 200
                orientation: Qt.Vertical
            }
            Column {
                spacing: 10
                BasicSlider {
                    width: 200
                    orientation: Qt.Horizontal
                }
                BasicSlider {
                    width: 200
                    orientation: Qt.Horizontal
                    themeColor: "gray"
                    LayoutMirroring.enabled: true
                    LayoutMirroring.childrenInherit: true
                }
            }
        }

        Row {
            id: scrollbar_row
            spacing: 10
            Text {
                width: 90
                height: 30
                renderType: Text.NativeRendering
                text: "ScrollBar:"
            }
            // 用ScrollView来展示ScrollBar
            ScrollView {
                id: scrollview_1
                width: 200
                height: 200
                clip: true
                Text {
                    text: "A B C \nD E F"
                    font.family: "SimHei"
                    font.pixelSize: 120
                }
                background: Rectangle {
                    border.color: "black"
                    border.width: 1
                }
                padding: 1
                ScrollBar.vertical: ScrollBar {
                    parent: scrollview_1
                    x: scrollview_1.mirrored ? 0 : scrollview_1.width - width
                    y: scrollview_1.topPadding
                    z: 10
                    height: scrollview_1.availableHeight
                    active: scrollview_1.ScrollBar.horizontal.active
                    // policy默认AsNeeded需要操作时才显示
                    policy: ScrollBar.AlwaysOn
                }
                ScrollBar.horizontal: ScrollBar {
                    parent: scrollview_1
                    x: scrollview_1.leftPadding
                    y: scrollview_1.height - height
                    z: 10
                    width: scrollview_1.availableWidth
                    active: scrollview_1.ScrollBar.vertical.active
                    policy: ScrollBar.AsNeeded
                }
                // 5.15中滚动条展示效果不对，会出现新旧两个滚动条
                // 可以给自定义ScrollBar设置一个属性，然后去判断是否为新定义的
                // Component.onCompleted: {
                //     let child_list = control.children;
                //     for (var i = 0; i < child_list.length; i++)
                //     {
                //         // 给自定义的scrollbar加一个自定义属性，此处为newBar
                //         // 遍历scrollview子节点，移除没有自定义属性的
                //         if (child_list[i] instanceof ScrollBar && !child_list[i].newBar)
                //             child_list[i].visible = false;
                //     }
                // }
                // 更简单的方法是直接用T.ScrollView，因为ScrollBar是在ScrollView定义时添加的
            }

            BasicScrollView {
                width: 200
                height: 200
                themeColor: "orange"
                Text {
                    text: "A B C \nD E F"
                    font.family: "SimHei"
                    font.pixelSize: 120
                }
            }
        }

        // BasicInputComponent.qml
        BasicInputComponent {}

        // 底部空白
        Item{
            width: 100
            height: 500
        }
    }

    Item {
        // 锚定到window去，不挡住scroll
        parent: Overlay.overlay
        anchors.fill: parent

        // 一个滑动的抽屉
        Drawer {
            id: drawer
            modal: true // 模态
            dim: true // 遮罩阴影
            interactive: false // 交互，默认可以从边缘拖拽
            edge: Qt.RightEdge // 右侧停靠
            // 默认点击pop外部区域就close，这里取消
            closePolicy: Popup.NoAutoClose
            width: 400
            height: parent.height
            padding: 0
            background: Rectangle {
                color: "#faa755"
                border.color: "#f47920"
                border.width: 2
                // radius: 4

                // drawer左侧按钮
                Rectangle {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.left
                    width: 30
                    height: width
                    radius: width/2
                    color: "#f47920"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: drawer.close()
                    }
                }
            }
        }

        // 屏幕右侧按钮
        Rectangle{
            visible: !drawer.visible
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.right
            width: 30
            height: width
            radius: width/2
            color: "#f47920"
            MouseArea {
                anchors.fill: parent
                onClicked: drawer.open()
            }
        }
    }
}
