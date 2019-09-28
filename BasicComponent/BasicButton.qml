import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12

//qtquickcontrols2\src\imports\controls\Button.qml
//from Customizing Button
T.Button {
    id:control

    //可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    property color textColor: "white"
    property color backgroundColor: "darkCyan"
    property color _bgNormalColor: backgroundColor               //普通状态背景颜色
    property color _bgCheckColor: Qt.lighter(backgroundColor)    //选中背景颜色
    property color _bgHoverColor: Qt.lighter(backgroundColor)    //悬停背景颜色
    property color _bgDownColor: Qt.darker(backgroundColor)      //按下背景颜色
    property color _textNormalColor: textColor  //普通状态文本颜色
    property color _textCheckColor: textColor   //高亮文本颜色
    property color _textHoverColor: textColor   //悬停文本颜色
    property color _textDownColor: textColor    //按下文本颜色
    property int radius: 0     //背景rect的圆角

    //源码中
    /*implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)*/
    implicitWidth: 90
    implicitHeight: 30
    leftPadding: 5
    rightPadding: 5
    spacing: 5
    //checkable: true
    font{
        family: "SimSun"
        pixelSize: 16
    }

    //icon.width: 24
    //icon.height: 24

    //按钮中显示的内容
    //源码用的impl里的IconLabel，但是这个不能单独设置renderType: Text.NativeRendering
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
            //width: control.icon.width
            //height: control.icon.height
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
            renderType: Text.NativeRendering
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            //wrapMode: Text.NoWrap
            elide: Text.ElideRight
            font: control.font
            //源码中IconLabel
            //color: control.checked || control.highlighted ? control.palette.brightText :
            //        control.flat && !control.down ?
            //      (control.visualFocus ? control.palette.highlight : control.palette.windowText) : control.palette.buttonText
            color: (control.checked||control.highlighted)
                   ? _textCheckColor
                   : control.down
                     ? _textDownColor
                     : control.hovered
                       ? _textHoverColor
                       : _textNormalColor
        }
    }

    //背景
    background: Rectangle{
        implicitWidth: control.implicitWidth
        implicitHeight: control.implicitHeight
        radius: control.radius
        //visible: !control.flat || control.down || control.checked || control.highlighted
        //源码中
        //color: Color.blend(control.checked || control.highlighted ?
        //                       control.palette.dark : control.palette.button,
        //                   control.palette.mid, control.down ? 0.5 : 0.0)

        //不同状态的颜色可以单独设置
        color: (control.checked||control.highlighted)
               ? _bgCheckColor
               : control.down
                 ? _bgDownColor
                 : control.hovered
                   ? _bgHoverColor
                   : _bgNormalColor
    }
}
