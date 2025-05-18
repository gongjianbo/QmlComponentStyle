import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T

// Qt5滚动区域
// 龚建波 2025-05-15
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\ScrollView.qml
T.ScrollView {
    id: control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    property color themeColor: "darkCyan"
    // 滚动条和边框的距离，区别于padding，padding是把内容挤压
    property int scrollBarPadding: 1

    // 默认宽度，参考Qt源码的写法，实际应用可以删减
    // Math.max表示取两者中最大值，1为默认背景宽度+左右偏移值，2为默认内容宽度+左右边距
    // implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    //                         contentWidth + leftPadding + rightPadding)
    // implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    //                          contentHeight + topPadding + bottomPadding)
    implicitWidth: contentWidth + leftPadding + rightPadding
    implicitHeight: contentHeight + topPadding + bottomPadding
    // 内容宽高
    // contentWidth/Height默认绑定的是内部Item的implicitWidth/Height
    // 如果Item只设置width/height不会影响contentWidth/Height值
    // contentWidth: 100
    // contentHeight: 100
    // 边距
    padding: 6
    // 超出范围的内容不显示
    clip: true

    // 背景
    // 如果内容超出范围，会压在background的border上
    // 可以把ScrollView fill在一个Rectangle中加margin
    // 或者在上层叠加四个边，或者是在上层叠加背景透明的Rectangle
    background: Rectangle {
        border.color: control.themeColor
        border.width: 1
    }

    // 竖向滚动条
    // NOTE 如果继承自ScrollView而不是T.ScrollView，那ScrollView定义中的滚动条也会显示
    // TODO 横向和竖向都显示的时候，交叠部分留出空白
    ScrollBar.vertical: BasicScrollBar {
        parent: control
        // 在view右侧，离边scrollBarPadding的距离
        x: control.mirrored ? control.scrollBarPadding : control.width - width - control.scrollBarPadding
        y: control.scrollBarPadding
        z: 10
        height: control.height - control.scrollBarPadding * 2
        // 横向竖向active关联起来
        active: control.ScrollBar.horizontal.active
        // 是否为交互式滚动条，如可以鼠标或触摸拖动，默认true
        // interactive: true
        themeColor: control.themeColor
    }

    // 横向滚动条
    ScrollBar.horizontal: BasicScrollBar {
        parent: control
        // 在view底部，离边scrollBarPadding的距离
        x: control.scrollBarPadding
        y: control.height - height - control.scrollBarPadding
        z: 10
        width: control.width - control.scrollBarPadding * 2
        active: control.ScrollBar.vertical.active
        themeColor: control.themeColor
    }
}
