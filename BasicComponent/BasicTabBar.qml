import QtQuick 2.15
import QtQuick.Templates 2.15 as T

// Qt5导航栏/标签栏
// 龚建波 2025-05-21
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\TabBar.qml
T.TabBar {
    id: control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    property color themeColor: "darkCyan"
    // 定义背景颜色
    property color backgroundColor: "white"
    // 定义边框颜色
    property color borderColor: themeColor

    // 默认宽度，参考Qt源码的写法，实际应用可以删减
    // Math.max表示取两者中最大值，1为默认背景宽度+左右偏移值，2为默认内容宽度+左右边距
    // implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    //                         contentWidth + leftPadding + rightPadding)
    // implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    //                          contentHeight + topPadding + bottomPadding)
    implicitWidth: contentWidth + leftPadding + rightPadding
    implicitHeight: 30
    // 传递到按钮列表，作为按钮间隔
    spacing: 1

    // 按钮列表
    contentItem: ListView {
        model: control.contentModel
        currentIndex: control.currentIndex
        // 按钮间隔
        spacing: control.spacing
        // 横向
        orientation: ListView.Horizontal
        // 内容无法拖拽超出可滑动区域的边界，且快速滑动时不会回弹效果
        boundsBehavior: Flickable.StopAtBounds
        // content大于view大小时，允许滑动
        flickableDirection: Flickable.AutoFlickIfNeeded
        // 滑动结束时起点对齐
        snapMode: ListView.SnapToItem

        // 高亮时缓动动画用时
        highlightMoveDuration: 0
        // 尽量让高亮项保持在指定范围内。但是，突出显示可能会移动到列表末尾的范围之外，或者由于鼠标交互而移动。
        highlightRangeMode: ListView.ApplyRange
        // 高亮区间
        preferredHighlightBegin: 40
        preferredHighlightEnd: width - 40
    }

    // 背景
    background: Rectangle {
        color: control.backgroundColor
        // 自定义样式，底部一条横线
        Rectangle {
            color: control.borderColor
            width: parent.width
            height: 1
            anchors.bottom: parent.bottom
        }
    }
}
