import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15

// Qt5勾选框样式自定义
// 龚建波 2025-03-07
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\CheckBox.qml
T.CheckBox {
    id:control

    // 定义主题颜色
    property color themeColor: "darkCyan"
    // 定义文本颜色
    property color textColor: "white"
    // 定义背景渐变色
    property Gradient backgroundGradient: control.pressed
                                          ? _pressGradient
                                          : (control.hovered || control.highlighted)
                                            ? _hoverGradient
                                            : control.checked
                                              ? _normalGradient
                                              : _normalGradient
    property Gradient _pressGradient: Gradient{
        GradientStop { position: 0.0; color: Qt.darker(themeColor) }
        GradientStop { position: 0.5; color: themeColor }
        GradientStop { position: 1.0; color: Qt.lighter(themeColor) }
    }
    property Gradient _hoverGradient: Gradient{
        GradientStop { position: 0.0; color: themeColor }
        GradientStop { position: 0.5; color: Qt.darker(themeColor) }
        GradientStop { position: 1.0; color: themeColor }
    }
    property Gradient _normalGradient: Gradient{
        GradientStop { position: 0.0; color: Qt.lighter(themeColor) }
        GradientStop { position: 0.5; color: themeColor }
        GradientStop { position: 1.0; color: Qt.lighter(themeColor) }
    }
    // 定义边框圆角
    property int radius: 4

    // 默认宽高
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
    // 勾选图标设置
    // icon.width: 24
    // icon.height: 24
    // 这个图标资源是Control模块默认提供的
    icon.source: "qrc:/qt-project.org/imports/QtQuick/Controls.2/images/check.png"
    icon.color: textColor
    hoverEnabled: true

    // 勾选图标
    indicator: Rectangle {
        implicitWidth: 24
        implicitHeight: 24
        // 设置勾选图标位置
        x: control.text ? control.leftPadding : control.leftPadding + (control.availableWidth - width) / 2
        y: (parent.height - height) / 2
        // indicator默认层级在background上，这里只是显示勾选部件的边框，所以color设置成透明
        color: "transparent"
        // 图标外面的矩形框
        border.width: 1
        border.color: icon.color
        // 用impl模块的ColorImage，便于设置图标颜色
        ColorImage {
            anchors.centerIn: parent
            // 借用Button已有的icon接口设置图标url
            source: control.icon.source
            // 借用Button已有的icon接口设置图标尺寸
            sourceSize: Qt.size(control.icon.width, control.icon.height)
            // 借用Button已有的icon接口设置图标颜色
            color: control.icon.color
            // 勾选状态下显示勾选图标
            visible: control.checkState === Qt.Checked
        }
        // 部分选中（Qt.PartiallyChecked）时不显示勾，显示一个实心方形
        // 设置CheckBox的tristate为true后才支持三态
        Rectangle {
            anchors.centerIn: parent
            width: parent.width / 2
            height: parent.height / 2
            color: icon.color
            // 半选状态下显示实心方形
            visible: control.checkState === Qt.PartiallyChecked
        }
    }

    // 文本描述
    // 源码中用的CheckLabel继承自Text，只是默认设置了AlignLeft+AlignVCenter+ElideRight
    contentItem: Text {
        // 文字内容
        text: control.text
        // 字体设置
        font: control.font
        // 颜色设置
        color: control.textColor
        // 文字对齐方式
        horizontalAlignment: Text.AlignHCenter
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
    background: Rectangle {
        // control设置了背景无关的宽高，这里也可以不设置默认宽高
        implicitWidth: control.implicitWidth
        implicitHeight: control.implicitHeight
        // 背景圆角
        radius: control.radius
        // 背景渐变
        gradient: control.backgroundGradient
    }
}
