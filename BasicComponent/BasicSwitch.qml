import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15

// Qt5滑动开关按钮
// 龚建波 2025-04-10
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\Switch.qml
// Switch继承自AbstractButton，增加了position和visualPosition两个属性
T.Switch {
    id: control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    property color themeColor: "darkCyan"
    // 定义文本颜色
    property color textColor: "black"
    // 按钮区域背景颜色
    property color indicatorBackgroundColor: control.checked
                                             ? themeColor
                                             : "gray"
    // 滑块边框颜色
    property color indicatorBorderColor: control.checked
                                         ? themeColor
                                         : "gray"
    // 按下时滑块颜色
    property color indicatorButtonColor: control.down
                                         ? Qt.lighter(themeColor)
                                         : "white"
    // 滑块边框宽度
    property int indicatorBorderWidth: control.visualFocus ? 2 : 1
    // 按钮区域背景上下边距
    property int indicatorVerticalPadding: 6

    // 默认宽度，参考Qt源码的写法，实际应用可以删减
    // Math.max表示取两者中最大值，1为默认背景宽度+左右偏移值，2为默认内容宽度+左右边距
    // inset和padding都是Control基类定义的，默认为0
    // implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    //                         implicitContentWidth + leftPadding + rightPadding)
    // 默认高度
    // implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    //                          implicitContentHeight + topPadding + bottomPadding,
    //                          implicitIndicatorHeight + topPadding + bottomPadding)
    implicitWidth: implicitContentWidth + leftPadding + rightPadding
    implicitHeight: implicitIndicatorHeight + topPadding + bottomPadding
    // 边距
    padding: 6
    // 图标和文字间距
    spacing: 6
    // 字体设置
    // 也可以给QApplication设置全局的默认字体
    font{
        family: "SimSun"
        pixelSize: 16
    }

    // 滑块区域
    indicator: PaddedRectangle {
        // 按钮背景
        implicitWidth: 56
        implicitHeight: 28

        x: text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2

        radius: height / 2
        leftPadding: 0
        rightPadding: 0
        // 上下通过padding收缩，留出空白
        padding: control.indicatorVerticalPadding
        color: control.indicatorBackgroundColor

        // 滑块
        Rectangle {
            x: Math.max(0, Math.min(parent.width - width, control.visualPosition * parent.width - (width / 2)))
            y: (parent.height - height) / 2
            width: 28
            height: 28
            radius: height / 2
            color: control.indicatorButtonColor
            border.width: control.indicatorBorderWidth
            border.color: control.indicatorBorderColor
            // 切换状态时的缓动动画
            Behavior on x {
                enabled: !control.down
                SmoothedAnimation { velocity: 200 }
            }
        }
    }

    // 文本区域
    contentItem: CheckLabel {
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0

        text: control.text
        font: control.font
        color: control.textColor
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        renderType: Text.NativeRendering
        elide: Text.ElideRight
    }
}
