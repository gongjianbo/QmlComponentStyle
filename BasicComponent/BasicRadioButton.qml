import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T

// Qt5单选框样式自定义
// 龚建波 2025-03-18
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\RadioButton.qml
// RadioButton继承自AbstractButton，并将checkable/autoExclusive设置为true
T.RadioButton {
    id: control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    property color themeColor: "darkCyan"
    // 定义文本颜色
    property color textColor: "black"
    // 定义勾选框背景色
    property color indicatorBackgroundColor: "transparent"
    // 定义勾选框颜色
    // pressed按下，hovered鼠标悬停，highlighted高亮，checked选中
    property color indicatorBorderColor: control.pressed
                                         ? Qt.darker(themeColor)
                                         : (control.hovered || control.highlighted)
                                           ? Qt.lighter(themeColor)
                                           : control.checked
                                             ? themeColor
                                             : themeColor
    // 定义勾选图标颜色
    property color indicatorButtonColor: indicatorBorderColor
    // 定义勾选框边框宽度
    property int indicatorBorderWidth: 1
    // 定义勾选框圆角，<0则为圆形勾选框
    property int indicatorRadius: -1

    // 默认宽度，参考Qt源码的写法，实际应用可以删减
    // Math.max表示取两者中最大值，1为默认背景宽度+左右偏移值，2为默认内容宽度+左右边距
    // inset和padding都是Control基类定义的，默认为0
    // implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    //                         implicitContentWidth + leftPadding + rightPadding)
    // 默认高度
    // implicitIndicatorHeight为indicator勾选部件的默认高度
    // implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    //                          implicitContentHeight + topPadding + bottomPadding,
    //                          implicitIndicatorHeight + topPadding + bottomPadding)
    // 通过内容计算宽高可能会导致一组按钮的宽高都不齐，可以用固定的默认宽高，或者固定高但是宽度自适应
    implicitWidth: implicitContentWidth + leftPadding + rightPadding
    implicitHeight: implicitIndicatorHeight + topPadding + bottomPadding
    // 边距
    padding: 0
    // 上下边距可以直接用verticalPadding，因为遇到过相关bug就单独设置下
    topPadding: 3
    bottomPadding: 3
    // 左右边距可以直接用horizontalPadding，因为遇到过相关bug就单独设置下
    leftPadding: 8
    rightPadding: 8
    // 图标和文字间距
    spacing: 6
    // 字体设置
    // 也可以给QApplication设置全局的默认字体
    font{
        family: "SimSun"
        pixelSize: 16
    }

    // Control组件点击之后，后续按空格也会触发点击，可以把空格过滤掉
    Keys.onPressed: event.accepted = (event.key === Qt.Key_Space)
    Keys.onReleased: event.accepted = (event.key === Qt.Key_Space)
    // 是否可以选中
    // checkable: true
    // 独占性，true则表示单选，在分组内互斥
    // autoExclusive: true
    // 是否检测hover鼠标悬停，默认会跟随父组件的设置
    hoverEnabled: true
    // 文本内容
    // text: "RadioButton"

    // 勾选图标
    indicator: Rectangle {
        implicitWidth: 24
        implicitHeight: 24
        // 设置勾选图标位置
        x: control.text ? control.leftPadding : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2
        // <0则为圆形勾选框
        radius: control.indicatorRadius < 0 ? width / 2 : control.indicatorRadius
        color: control.indicatorBackgroundColor
        border.width: control.indicatorBorderWidth
        border.color: control.indicatorBorderColor
        // 选中后的实心圆圈
        Rectangle {
            anchors.fill: parent
            anchors.margins: parent.width / 6 + control.indicatorBorderWidth
            // 和边框一样的圆角
            radius: control.indicatorRadius < 0 ? width / 2 : control.indicatorRadius
            color: control.indicatorButtonColor
            // 选中后显示
            visible: control.checked
        }
    }

    // 文本描述
    // 源码中用的CheckLabel继承自Text
    contentItem: Text {
        // 文字内容
        text: control.text
        // 字体设置
        font: control.font
        // 颜色设置
        color: control.textColor
        // 文字对齐方式
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        // 单独设置文本组件的渲染方式
        renderType: Text.NativeRendering
        // 文字超出按钮范围显示省略号
        elide: Text.ElideRight
        // contentItem宽度是包含了indicator的，通过padding把位置留出来
        leftPadding: control.indicator.width + control.spacing
        rightPadding: 0
    }

    // 背景
    // background: Rectangle { }
}
