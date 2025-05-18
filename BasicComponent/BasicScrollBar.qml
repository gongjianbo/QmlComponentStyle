import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T

// Qt5滚动条
// 龚建波 2025-05-18
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\ScrollBar.qml
T.ScrollBar {
    id: control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    property color themeColor: "darkCyan"
    // 定义滚动条颜色
    property color handleColor: control.pressed
                                ? Qt.darker(themeColor)
                                : control.hovered
                                  ? Qt.darker(themeColor, 1.15)
                                  : themeColor

    // 默认宽度，参考Qt源码的写法，实际应用可以删减
    // Math.max表示取两者中最大值，1为默认背景宽度+左右偏移值，2为默认内容宽度+左右边距
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    // 背景整体size和handle的间隔
    padding: 1
    // 参考源码设置
    visible: control.policy !== T.ScrollBar.AlwaysOff
    // 最小长度占比 [0.0, 1.0]，他这个用百分比不用绝对值就很迷
    minimumSize: orientation == Qt.Horizontal ? height / width : width / height
    // 表示滚动条是否处于活跃状态，附加到滚动区域会自动设置
    // active: true
    // 是否为交互式滚动条，如可以鼠标或触摸拖动，默认true
    // interactive: true
    // 方向，横向或竖向，默认横向horizontal
    // orientation: Qt.Horizontal
    // 是否为横向-只读：horizontal
    // 是否为竖向-只读：vertical
    // 显示策略，默认内容越界且交互操作时才显示ScrollBar.AsNeeded
    // policy: ScrollBar.AsNeeded
    // 需要时显示：ScrollBar.AsNeeded
    // 永远不显示：ScrollBar.AlwaysOff
    // 永远显示：ScrollBar.AlwaysOn
    // 步进值，默认0
    // stepSize: 0
    // 滑块对齐模式
    // Slider.NoSnap 默认不对齐
    // Slider.SnapAlways 拖动手柄时，滑块会对齐合法值，如设置了stepSize那就根据步进值对齐
    // Slider.SnapOnRelease 滑块在拖动时不会对齐，而仅在释放手柄后对齐
    // snapMode: Slider.NoSnap

    // 根据步进值减少，未设置步进值则为0.1
    // decrease()
    // 根据步进值增加，未设置步进值则为0.1
    // increase()

    // handle滑块部分
    contentItem: Rectangle {
        implicitWidth: 10
        implicitHeight: 10
        // 圆角用短边1/2
        radius: control.horizontal ? height / 2 : width / 2
        color: control.handleColor
        // 参考源码，通过opacity来控制handle显示隐藏
        // 源码默认行为ScrollBar.AsNeeded是鼠标放上去或者滚动滚轮才会出现滚动条
        // 这里修改为widgets那种内容超出范围就显示的样子
        opacity: (control.policy === T.ScrollBar.AlwaysOn || control.size < 1.0) ? 1.0 : 0.0
        // 源码的交互动画这里没用到
        // opacity: 0.0
        // states: State {
        //     name: "active"
        //     when: control.policy === T.ScrollBar.AlwaysOn || (control.active && control.size < 1.0)
        //     PropertyChanges { target: control.contentItem; opacity: 0.75 }
        // }
        // transitions: Transition {
        //     from: "active"
        //     SequentialAnimation {
        //         PauseAnimation { duration: 450 }
        //         NumberAnimation { target: control.contentItem; duration: 200; property: "opacity"; from:1.0; to: 0.0 }
        //     }
        // }
    }
}
