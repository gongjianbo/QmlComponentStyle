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
