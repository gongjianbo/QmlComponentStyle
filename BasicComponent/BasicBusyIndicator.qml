import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls.impl 2.15

// Qt5繁忙等待指示器
// 龚建波 2025-04-16
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\BusyIndicator.qml
// 继承自Control，只增加了一个running动画运行状态属性，样式除了颜色其他没法自定义
T.BusyIndicator {
    id: control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    property color themeColor: "darkCyan"
    // 定义单个圆点边框颜色
    property color indicatorBorderColor: Qt.lighter(themeColor)
    // 定义单个圆点填充色
    property color indicatorFillColor: themeColor

    // 默认宽度
    implicitWidth: implicitContentWidth + leftPadding + rightPadding
    // 默认高度
    implicitHeight: implicitContentHeight + topPadding + bottomPadding
    // 边距
    padding: 6

    // 指示器部件
    contentItem: BusyIndicatorImpl {
        implicitWidth: 80
        implicitHeight: 80
        // 单个圆点边框颜色
        pen: control.indicatorBorderColor
        // 单个圆圈填充色
        fill: control.indicatorFillColor
        // 等待动画运行状态
        running: control.running
        // 参考源码写法，非running时不显示
        opacity: control.running ? 1 : 0
        // 显示隐藏透明度过渡动画
        Behavior on opacity {
            OpacityAnimator { duration: 250 }
        }
    }
}
