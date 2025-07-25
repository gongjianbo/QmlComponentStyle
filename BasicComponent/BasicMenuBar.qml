import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15

// Qt5菜单栏
// 龚建波 2025-07-25
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\MenuBar.qml
T.MenuBar {
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

    // 菜单项样式
    delegate: BasicMenuBarItem { }

    // 按钮列表
    contentItem: Row {
        spacing: control.spacing
        Repeater {
            model: control.contentModel
        }
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
