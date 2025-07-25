import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T

// Qt5菜单分割线
// 龚建波 2025-07-25
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\MenuSeparator.qml
T.MenuSeparator {
    id: control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    // MenuSeparator没有附加属性来访问该对象，只能往父节点找
    property color themeColor: {
        var p = control.parent
        while (p) {
            if (p instanceof BasicMenu) {
                if ("themeColor" in p)
                    return p.themeColor
                else
                    break
            }
            p = p.parent
        }
        return "darkCyan"
    }
    // 定义背景颜色
    property color backgroundColor: "white"
    // 定义分割线颜色
    property color contentColor: themeColor

    // 默认宽度，参考Qt源码的写法，实际应用可以删减
    // Math.max表示取两者中最大值，1为默认背景宽度+左右偏移值，2为默认内容宽度+左右边距
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    // 边距
    padding: 0
    topPadding: 4
    bottomPadding: 4
    // 内容
    contentItem: Rectangle {
        implicitWidth: 160
        implicitHeight: 1
        color: contentColor
    }
    // 背景
    background: Rectangle {
        color: backgroundColor
    }
}
