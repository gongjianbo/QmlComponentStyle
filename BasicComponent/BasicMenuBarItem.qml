import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15

// Qt5菜单栏选项
// 龚建波 2025-07-25
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\MenuBarItem.qml
T.MenuBarItem {
    id: control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    // 从访问Bar可以发现QML接口设计有一些没统一，TabBar有附加属性，MenuBarItem用成员属性，ToolBar没提供接口访问
    property color themeColor: menuBar && menuBar.themeColor
                               ? menuBar.themeColor
                               : "darkCyan"
    // 定义文本颜色
    property color textColor: "white"
    // 定义背景色
    // pressed按下，hovered鼠标悬停，highlighted菜单弹出/hover
    property color backgroundColor: (control.pressed)
                                    ? Qt.darker(themeColor)
                                    : (control.hovered || control.highlighted)
                                      ? Qt.lighter(themeColor)
                                      : themeColor

    // 默认宽度，参考Qt源码的写法，实际应用可以删减
    // Math.max表示取两者中最大值，1为默认背景宽度+左右偏移值，2为默认内容宽度+左右边距
    // implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    //                         implicitContentWidth + leftPadding + rightPadding)
    // 默认高度
    // implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    //                          implicitContentHeight + topPadding + bottomPadding,
    //                          implicitIndicatorHeight + topPadding + bottomPadding)
    implicitWidth: implicitContentWidth + leftPadding + rightPadding
    implicitHeight: 30
    // 边距
    padding: 0
    leftPadding: 12
    rightPadding: 12
    // 图标和文字间隔
    spacing: 6
    // 字体设置
    // 也可以给QApplication设置全局的默认字体
    font{
        family: "SimSun"
        pixelSize: 16
    }

    // 带图标的Label
    // 自定义的QmlIconLabel，参考源码IconLabel
    contentItem: QmlIconLabel {
        text: control.text
        font: control.font
        color: control.textColor
        spacing: control.spacing
        source: control.icon.source
    }

    // 背景
    background: Rectangle {
        // 留的1px是和自定义MenuBar底部的样式配合的
        height: control.height - 1
        color: control.backgroundColor
    }
}
