import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T

// Qt5延时按钮样式自定义
// 龚建波 2025-04-09
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\DelayButton.qml
// DelayButton继承自AbstractButton，增加了delay/progress/transition三个属性
T.DelayButton {
    id: control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    property color themeColor: "darkCyan"
    // 定义选中后主题色
    property color maskThemeColor: "green"
    // 定义未选中文本颜色
    property color textColor: "white"
    // 定义选中后文本颜色
    property color maskTextColor: "yellow"
    // 定义背景颜色
    // pressed按下，hovered鼠标悬停，highlighted高亮，checked选中
    // 判断了pressed动画会跳过一段
    property color backgroundColor: (control.hovered)
                                    ? Qt.lighter(themeColor)
                                    : themeColor
    // 定义选中后背景色
    property color maskBackgroundColor: (control.hovered)
                                        ? Qt.lighter(maskThemeColor)
                                        : maskThemeColor
    // 定义边框宽度
    property int borderWidth: 0
    // 定义边框颜色
    property color borderColor: Qt.darker(themeColor)
    // 定义边框圆角
    property int radius: 0

    // 默认宽度，参考Qt源码的写法，实际应用可以删减
    // Math.max表示取两者中最大值，1为默认背景宽度+左右偏移值，2为默认内容宽度+左右边距
    // inset和padding都是Control基类定义的，默认为0
    // implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    //                         implicitContentWidth + leftPadding + rightPadding)
    // 默认高度
    // implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    //                          implicitContentHeight + topPadding + bottomPadding)
    implicitWidth: implicitContentWidth + leftPadding + rightPadding
    implicitHeight: implicitBackgroundHeight + topPadding + bottomPadding
    // 边距
    padding: 0
    // 左右边距可以直接用horizontalPadding，因为遇到过相关bug就单独设置下
    leftPadding: 8
    rightPadding: 8
    // 字体设置
    // 也可以给QApplication设置全局的默认字体
    font{
        family: "SimSun"
        pixelSize: 16
    }

    // Control组件点击之后，后续按空格也会触发点击，可以把空格过滤掉
    Keys.onPressed: event.accepted = (event.key === Qt.Key_Space)
    Keys.onReleased: event.accepted = (event.key === Qt.Key_Space)
    // 动画时长，默认300ms
    delay: 500
    // 动画进度[0.0-1.0]，只读属性
    // onProgressChanged: { }
    // 过渡动画
    transition: Transition {
        NumberAnimation {
            duration: control.delay * (control.pressed ? 1.0 - control.progress : 0.3 * control.progress)
        }
    }

    // 按钮中显示的内容
    contentItem: ItemGroup {

        // 未选中时的文字
        ClippedText {
            clip: control.progress > 0
            clipX: -control.leftPadding + control.progress * control.width
            clipWidth: (1.0 - control.progress) * control.width
            visible: control.progress < 1

            text: control.text
            font: control.font
            // opacity: enabled ? 1 : 0.3
            color: textColor
            renderType: Text.NativeRendering
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        // 按下或选中时的遮罩文字
        ClippedText {
            clip: control.progress > 0
            clipX: -control.leftPadding
            clipWidth: control.progress * control.width
            visible: control.progress > 0

            text: control.text
            font: control.font
            // opacity: enabled ? 1 : 0.3
            color: maskTextColor
            renderType: Text.NativeRendering
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
    }

    // 背景
    background: Rectangle {
        implicitWidth: 100
        // ItemGroup implicitWidth/Height属性只读，所以设置background的
        implicitHeight: 30
        // 背景圆角
        radius: control.radius
        // 背景颜色
        color: control.backgroundColor
        // 背景边框
        border.width: control.borderWidth
        border.color: control.borderColor

        // 按下或选中时的遮罩背景
        PaddedRectangle {
            radius: control.radius
            width: control.progress * parent.width
            height: parent.height
            color: control.maskBackgroundColor
        }
    }
}
