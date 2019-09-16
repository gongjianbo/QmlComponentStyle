import QtQuick 2.12
import QtQuick.Controls 2.12
//import QtQuick.Controls.impl 2.12

//qtquickcontrols2\src\imports\controls\Button.qml

Button {
    id:control

    property color themeColor: "darkCyan" //主题颜色
    property color textColor: "white"     //文本颜色

    property Gradient _highlightGradient: Gradient{
        GradientStop { position: 0.0; color: "gray" }
        GradientStop { position: 0.5; color: "gray" }
        GradientStop { position: 1.0; color: "gray" }
    }
    property Gradient _downGradient: Gradient{
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

    //default
    /*implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)*/
    implicitWidth: 90
    implicitHeight: 30
    leftPadding: 5
    rightPadding: 5
    //checkable: true
    font{
        family: "SimSun"
        pixelSize: 16
    }

    //按钮中显示的内容：图标+文字
    contentItem: Row{
        id:btn_row
        width: control.width
        spacing: control.spacing
        Image {
            id:btn_icon
            anchors{
                verticalCenter: parent.verticalCenter
            }
            source: control.icon.source //借用icon的接口
        }
        Text{
            id:btn_text
            anchors{
                verticalCenter: parent.verticalCenter
            }
            width: btn_icon.width
                   ? btn_row.width-btn_row.spacing-btn_icon.width
                   : btn_row.width
            text: control.text
            color: control.textColor
            renderType: Text.NativeRendering
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            //wrapMode: Text.NoWrap
            elide: Text.ElideRight
            font: control.font
        }
    }
    /*contentItem: Text{
        text: control.text
        color: control.textColor
        renderType: Text.NativeRendering
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        //wrapMode: Text.NoWrap
        elide: Text.ElideRight
        font: control.font
    }*/

    //import QtQuick.Controls.impl 2.12
    /*contentItem: IconLabel {
        spacing: control.spacing
        mirrored: control.mirrored

        icon: control.icon
        text: control.text
        font: control.font
        color: control.textColor
    }*/

    //背景
    background: Rectangle{
        implicitWidth: control.implicitWidth
        implicitHeight: control.implicitHeight
        radius: 3
        gradient: (control.checked||control.highlighted)
                  ? _highlightGradient
                  : control.down
                    ? _downGradient
                    : control.hovered
                      ? _hoverGradient
                      : _normalGradient

    }
}
