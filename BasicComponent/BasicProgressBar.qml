import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15

// Qt5进度条
// 龚建波 2025-04-16
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\ProgressBar.qml
T.ProgressBar {
    id: control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    property color themeColor: "darkCyan"

    // 默认宽度，参考Qt源码的写法，实际应用可以删减
    // Math.max表示取两者中最大值，1为默认背景宽度+左右偏移值，2为默认内容宽度+左右边距
    // inset和padding都是Control基类定义的，默认为0
    // implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    //                         implicitContentWidth + leftPadding + rightPadding)
    // 默认高度
    // implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    //                          implicitContentHeight + topPadding + bottomPadding)
    implicitWidth: 200
    implicitHeight: 10

    // 进度起始值，默认0.0
    // from: 0
    // 进度最大值，默认1.0
    // to: 100
    // 当前进度之，默认0.0
    // value: 50
    // 进度逻辑位置[0.0, 1.0] postion
    // 进度可视位置 visualPosition
    // 是否为不确定模式 indeterminate
    // 不确定模式下的进度条显示作正在进行中（类似BusyIndicator），但不显示已取得的进度

    // 进度条部件，可惜不能设置圆角
    contentItem: ProgressBarImpl {
        implicitWidth: 120
        implicitHeight: 10
        scale: control.mirrored ? -1 : 1
        // 进度
        progress: control.position
        // indeterminate表示没有具体进度值，是一个进度动画
        indeterminate: control.visible && control.indeterminate
        color: themeColor
    }

    // 背景框
    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 10
        y: (control.height - height) / 2
        height: 10
        border.width: 1
        border.color: themeColor
    }
}
