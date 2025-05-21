import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Templates 2.15 as T

// Qt5导航/标签按钮
// 龚建波 2025-05-21
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\TabButton.qml
T.TabButton {
    id: control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    property color themeColor: TabBar.tabBar && TabBar.tabBar.themeColor
                               ? TabBar.tabBar.themeColor
                               : "darkCyan"
    // 定义文本颜色
    property color textColor: "white"
    // 定义背景颜色
    // pressed按下，hovered鼠标悬停，highlighted高亮，checked选中
    property color backgroundColor: (control.pressed || control.checked)
                                    ? Qt.darker(themeColor)
                                    : (control.hovered || control.highlighted)
                                      ? Qt.lighter(themeColor)
                                      : themeColor

    // 默认宽度，参考Qt源码的写法，实际应用可以删减
    // Math.max表示取两者中最大值，1为默认背景宽度+左右偏移值，2为默认内容宽度+左右边距
    // implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    //                         implicitContentWidth + leftPadding + rightPadding)
    // implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    //                          implicitContentHeight + topPadding + bottomPadding)
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
        // 留的1px是和自定义TabBar底部的样式配合的
        height: control.height - 1
        color: control.backgroundColor
    }
}
