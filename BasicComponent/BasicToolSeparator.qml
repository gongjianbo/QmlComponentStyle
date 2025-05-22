import QtQuick 2.15
import QtQuick.Templates 2.15 as T

// Qt5工具栏分隔线
// 龚建波 2025-05-21
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\ToolSeparator.qml
T.ToolSeparator {
    id: control

    // 定义分割线颜色
    property color separatorColor: "white"

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    // 如果是竖向左右留更大边距，如果是横向上下留更大边距
    padding: vertical ? 6 : 2
    verticalPadding: vertical ? 2 : 6

    // 分割线色块
    contentItem: Rectangle {
        // 如果是竖向宽度为1，如果是横向高度为1
        implicitWidth: vertical ? 1 : 20
        implicitHeight: vertical ? 20 : 1
        color: control.separatorColor
        opacity: 0.5
    }
}
