import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Window 2.15

// Qt5菜单
// 龚建波 2025-07-25
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\Menu.qml
T.Menu {
    id: control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    property color themeColor: {
        var p = control.parent
        while (p) {
            if (p instanceof BasicMenu || p instanceof BasicMenuBar ||
                    p instanceof BasicMenuItem || p instanceof BasicMenuBarItem) {
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
    // 定义边框颜色
    property color borderColor: themeColor

    // 默认宽度，参考Qt源码的写法，实际应用可以删减
    // Math.max表示取两者中最大值，1为默认背景宽度+左右偏移值，2为默认内容宽度+左右边距
    // implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    //                         contentWidth + leftPadding + rightPadding)
    // implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    //                          contentHeight + topPadding + bottomPadding)
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)
    // 外边距
    margins: 0
    // 边距，菜单项和菜单窗口边框的间隔
    padding: 1
    // 多级菜单时子菜单重叠像素数
    overlap: 1
    // 字体设置
    // 也可以给QApplication设置全局的默认字体
    font{
        family: "SimSun"
        pixelSize: 16
    }

    // 菜单项样式
    delegate: BasicMenuItem { }

    // 菜单内容用ListView组织
    contentItem: ListView {
        implicitHeight: contentHeight
        model: control.contentModel
        // 是否可交互（如拖动内容）
        interactive: Window.window ? contentHeight > Window.window.height : false
        clip: true
        currentIndex: control.currentIndex
        highlightMoveDuration: 0
        ScrollIndicator.vertical: ScrollIndicator {}
    }

    // 菜单弹框背景
    background: QmlDropShadow {
        implicitWidth: 160
        implicitHeight: 32
        color: control.backgroundColor
        border.width: 1
        border.color: control.borderColor
    }

    // 模态时窗口遮罩
    T.Overlay.modal: Rectangle {
        color: Color.transparent(control.palette.shadow, 0.5)
    }

    // 非模态时窗口遮罩
    T.Overlay.modeless: Rectangle {
        color: Color.transparent(control.palette.shadow, 0.12)
    }
}
