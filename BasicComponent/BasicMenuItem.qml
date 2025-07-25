import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Shapes 1.15

// Qt5菜单项
// 龚建波 2025-07-25
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\MenuItem.qml
T.MenuItem {
    id: control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    property color themeColor: menu && menu.themeColor
                               ? menu.themeColor
                               : "darkCyan"
    // 定义背景颜色
    property color backgroundColor: control.highlighted ? themeColor : "white"
    // 定义文本颜色
    property color textColor: control.highlighted ? "white" : "black"
    // 定义图标颜色
    property color indicatorColor: textColor
    // 展开二级菜单图标颜色
    property color arrowColor: textColor

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
    leftPadding: 6
    rightPadding: 6
    // 小部件间隔
    spacing: 6
    // 字体设置
    // 也可以给QApplication设置全局的默认字体
    font{
        family: "SimSun"
        pixelSize: 16
    }

    // 文字和图标
    contentItem: QmlIconLabel {
        readonly property real arrowPadding: control.subMenu && control.arrow ? control.arrow.width + control.spacing : 0
        readonly property real indicatorPadding: control.checkable && control.indicator ? control.indicator.width + control.spacing : 0
        controlRow.leftPadding: indicatorPadding
        controlRow.rightPadding: arrowPadding
        controlText.horizontalAlignment: Text.AlignLeft

        spacing: control.spacing
        source: control.icon.source
        text: control.text
        font: control.font
        color: control.textColor
    }

    // 勾选图标
    indicator: ColorImage {
        x: control.mirrored ? control.width - width - control.rightPadding : control.leftPadding
        y: control.topPadding + (control.availableHeight - height) / 2

        visible: control.checked
        source: control.checkable ? "qrc:/qt-project.org/imports/QtQuick/Controls.2/images/check.png" : ""
        color: control.indicatorColor
        defaultColor: control.indicatorColor
    }

    // 展开二级菜单的图标
    arrow: ColorImage {
        x: control.mirrored ? control.leftPadding : control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2

        visible: control.subMenu
        mirror: control.mirrored
        source: control.subMenu ? "qrc:/qt-project.org/imports/QtQuick/Controls.2/images/arrow-indicator.png" : ""
        color: control.arrowColor
        defaultColor: control.arrowColor
    }

    // 背景
    background: Rectangle {
        implicitWidth: 120
        implicitHeight: 30
        // 参考源码，这应该是给border留的1px位置
        x: 1
        y: 1
        width: control.width - 2
        height: control.height - 2
        color: control.backgroundColor
    }
}

