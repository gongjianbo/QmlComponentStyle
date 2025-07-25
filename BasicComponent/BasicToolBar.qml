import QtQuick 2.15
import QtQuick.Templates 2.15 as T

// Qt5工具栏
// 龚建波 2025-05-21
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\ToolBar.qml
T.ToolBar {
    id: control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    property color themeColor: "darkCyan"
    // 定义背景颜色
    property color backgroundColor: themeColor

    // 默认宽度，参考Qt源码的写法，实际应用可以删减
    // Math.max表示取两者中最大值，1为默认背景宽度+左右偏移值，2为默认内容宽度+左右边距
    // implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    //                         contentWidth + leftPadding + rightPadding)
    // implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    //                          contentHeight + topPadding + bottomPadding)
    implicitWidth: contentWidth + leftPadding + rightPadding
    implicitHeight: 30

    // 背景
    background: Rectangle {
        color: control.backgroundColor
    }
}
