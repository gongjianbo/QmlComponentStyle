import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T

// Qt5数值编辑框样式自定义
// 龚建波 2025-04-24
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\SpinBox.qml
T.SpinBox {
    id: control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    property color themeColor: "darkCyan"
    // 定义文本颜色
    property color textColor: "black"
    // 定义边框颜色
    property color borderColor: themeColor
    // 定义边框宽度
    property int borderWidth: 1
    // 定义文本背景色
    property color backgroundNormalColor: "white"
    // 定义文本背景焦点色
    property color backgroundFocusColor: backgroundNormalColor
    // 定义按钮图标颜色
    property color indicatorNormalColor: "black"
    property color indicatorDisableColor: "gray"
    // 定义按钮颜色
    property color buttonNormalColor: "white"
    property color buttonHoverColor: Qt.lighter(buttonNormalColor)
    property color buttonPressColor: Qt.darker(buttonNormalColor)

    // 默认宽度，参考Qt源码的写法，实际应用可以删减
    // Math.max表示取两者中最大值，1为默认背景宽度+左右偏移值，2为默认内容宽度+左右按钮宽度+三者间距
    // inset和padding都是Control基类定义的，默认为0
    // implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    //                         contentItem.implicitWidth + 2 * padding +
    //                         up.implicitIndicatorWidth +
    //                         down.implicitIndicatorWidth)
    // 默认高度
    // implicitHeight: Math.max(implicitContentHeight + topPadding + bottomPadding,
    //                          implicitBackgroundHeight,
    //                          up.implicitIndicatorHeight,
    //                          down.implicitIndicatorHeight)
    implicitWidth: 120
    implicitHeight: 30

    // 部件间隔，没用到
    // spacing: 0
    // 边距
    padding: 0
    // 左边距包含了左侧按钮宽度
    leftPadding: padding + (down.indicator ? down.indicator.width : 0)
    // 右边距包含了右侧按钮宽度
    rightPadding: padding + (up.indicator ? up.indicator.width : 0)
    // 字体设置
    // 也可以给QApplication设置全局的默认字体
    font{
        family: "SimSun"
        pixelSize: 16
    }

    // 最小值，默认0
    // from: 0
    // 最大值，默认99
    // to: 99
    // 当前值，默认0
    // value: 0
    // 点加减后的步进值，默认1
    // stepSize: 1
    // 输入行为，传给InputMethod，如Qt.ImhDate限制为日期格式
    // inputMethodHints: Qt.ImhNone
    // wrap为true则上下按钮设置是循环设置范围内值的，默认false
    // wrap: true
    // 限制输入
    validator: IntValidator {
        // 语言区域会影响字符格式化
        locale: control.locale.name
        // 最小值
        bottom: Math.min(control.from, control.to)
        // 最大值
        top: Math.max(control.from, control.to)
    }
    // 值到文本映射，返回的值给control.displayText
    // textFromValue: function(val) { return val }
    // 文本到值映射
    // valueFromText: function(txt) { return txt }

    // 中间的数值框
    contentItem: Rectangle {
        // 增加z值可以把border叠加到按钮之上
        z: 2
        color: control.activeFocus
               ? backgroundFocusColor
               : backgroundNormalColor
        // 编辑/显示内容
        TextInput {
            anchors.fill: parent
            // 显示的内容，可以通过textFromValue转换
            text: control.displayText
            // 一些编辑器属性绑定SpinBox设置的属性
            readOnly: !control.editable
            validator: control.validator
            inputMethodHints: control.inputMethodHints
            // 文本颜色
            color: control.textColor
            // 鼠标框选文本样式
            selectByMouse: true
            selectedTextColor: "white"
            selectionColor: "black"
            // 字体设置
            font: control.font
            // 单独设置文本组件的渲染方式
            renderType: Text.NativeRendering
            // 居中对齐
            horizontalAlignment: Qt.AlignHCenter
            verticalAlignment: Qt.AlignVCenter
        }
        // 编辑框边框
        Rectangle {
            anchors.fill: parent
            anchors.margins: 0
            // 负边距和按钮边框重合
            anchors.leftMargin: -control.borderWidth
            anchors.rightMargin: -control.borderWidth
            color: "transparent"
            border.color: control.borderColor
            border.width: control.borderWidth
        }
    }

    // 增加按钮
    up.indicator: Rectangle {
        // 定位到右侧
        x: parent.width - width
        height: parent.height
        implicitWidth: 30
        implicitHeight: 30
        // 按钮背景色
        color: up.pressed
               ? control.buttonPressColor
               : up.hovered
                 ? control.buttonHoverColor
                 : control.buttonNormalColor
        // 按钮边框
        border.width: control.borderWidth
        border.color: control.borderColor
        // 加号
        Rectangle {
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            width: parent.width / 3
            height: 2
            color: enabled ? control.indicatorNormalColor : control.indicatorDisableColor
        }
        Rectangle {
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            width: 2
            height: parent.width / 3
            color: enabled ? control.indicatorNormalColor : control.indicatorDisableColor
        }
    }

    // 减少按钮
    down.indicator: Rectangle {
        // 定位到左侧
        x: 0
        height: parent.height
        implicitWidth: 30
        implicitHeight: 30
        // 按钮背景色
        color: down.pressed
               ? control.buttonPressColor
               : down.hovered
                 ? control.buttonHoverColor
                 : control.buttonNormalColor
        // 按钮边框
        border.width: control.borderWidth
        border.color: control.borderColor
        // 减号
        Rectangle {
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            width: parent.width / 3
            height: 2
            color: enabled ? control.indicatorNormalColor : control.indicatorDisableColor
        }
    }

    // 不设置整体背景
    background: Item { }
}
