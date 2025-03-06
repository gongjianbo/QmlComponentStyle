import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15

// Qt5按钮样式自定义
// 龚建波 2025-03-06
// 基础样式定义见BasicButton
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\Button.qml
T.Button {
    id:control

    // 定义主题颜色
    property color themeColor: "darkCyan"
    // 定义文本颜色
    property color textColor: "white"
    // 定义背景渐变色
    property Gradient backgroundGradient: (control.pressed || control.checked)
                                          ? _pressGradient
                                          : (control.hovered || control.highlighted)
                                            ? _hoverGradient
                                            : _normalGradient
    property Gradient _pressGradient: Gradient {
        GradientStop { position: 0.0; color: Qt.darker(themeColor) }
        GradientStop { position: 0.5; color: themeColor }
        GradientStop { position: 1.0; color: Qt.lighter(themeColor) }
    }
    property Gradient _hoverGradient: Gradient {
        GradientStop { position: 0.0; color: themeColor }
        GradientStop { position: 0.5; color: Qt.darker(themeColor) }
        GradientStop { position: 1.0; color: themeColor }
    }
    property Gradient _normalGradient: Gradient {
        GradientStop { position: 0.0; color: Qt.lighter(themeColor) }
        GradientStop { position: 0.5; color: themeColor }
        GradientStop { position: 1.0; color: Qt.lighter(themeColor) }
    }
    // 定义边框圆角
    property int radius: 4

    // 默认宽高
    implicitWidth: implicitContentWidth + leftPadding + rightPadding
    implicitHeight: implicitContentHeight
    // 边距
    padding: 0
    leftPadding: 8
    rightPadding: 8
    spacing: 6
    font{
        family: "SimSun"
        pixelSize: 16
    }
    hoverEnabled: true

    // 按钮中显示的内容
    contentItem: Item {
        implicitWidth: btn_text.implicitWidth + btn_icon.iconWidth
        implicitHeight: 30
        // Row会根据内容计算出implicitWidth
        Row {
            id: btn_row
            // 居中显示
            anchors.centerIn: parent
            // 图标和文字间隔
            spacing: control.spacing
            // 用impl模块的ColorImage，便于设置图标颜色
            ColorImage {
                id: btn_icon
                // 除了text外的内容宽度
                property int iconWidth: (btn_icon.implicitWidth > 0 ? btn_icon.implicitWidth + btn_row.spacing : 0)
                // 在Row内上下居中
                anchors.verticalCenter: parent.verticalCenter
                // 借用Button已有的icon的接口设置图标路径
                source: control.icon.source
                // 图标颜色
                color: control.textColor
            }
            Text {
                id: btn_text
                // 如果按钮宽度小于默认宽度文字需要显示省略号，得先设置Text宽度
                width: (control.width - btn_icon.iconWidth - control.leftPadding - control.rightPadding)
                // 在Row内上下居中
                anchors.verticalCenter: parent.verticalCenter
                // 按钮文字内容
                text: control.text
                // 文字颜色
                color: control.textColor
                // 单独设置文本组件的渲染方式
                renderType: Text.NativeRendering
                // 文字对齐方式，设置Text宽高后设置才有意义
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                // 换行设置，按钮一般没有换行
                // wrapMode: Text.NoWrap
                // 文字超出按钮范围显示省略号
                elide: Text.ElideMiddle
                // 字体设置
                font: control.font
            }
        }
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
