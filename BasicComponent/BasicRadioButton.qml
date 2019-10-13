import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T

//qtquickcontrols2\src\imports\controls\RadioButton.qml
//from Customizing RadioButton
T.RadioButton {
    id: control

    //只是把源码里的颜色改了下
    property color textColor: "darkCyan"          //文字颜色
    property color radioColor: "darkCyan" //背景颜色
    property color _textNormalColor: textColor               //普通状态文本颜色
    property color _textCheckColor: textColor                //选中文本颜色
    property color _textFocusColor: Qt.lighter(textColor)    //焦点或悬停
    property color _radioNormalColor: radioColor             //普通状态背景颜色
    property color _radioCheckColor: radioColor              //选中背景颜色
    property color _radioFocusColor: Qt.lighter(radioColor)  //焦点或悬停

    property int radius: -1

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6
    font{
        family: "SimSun"
        pixelSize: 16
    }

    // keep in sync with RadioDelegate.qml (shared RadioIndicator.qml was removed for performance reasons)
    indicator: Rectangle {
        implicitWidth: 28
        implicitHeight: 28

        x: text
           ? (control.mirrored
              ? control.width - width - control.rightPadding
              : control.leftPadding)
           : control.leftPadding + (control.availableWidth - width)/2
        y: control.topPadding + (control.availableHeight - height)/2

        radius: control.radius<0 ? width/2 : control.radius
        color: "transparent"
        //color: control.down ? control.palette.light : control.palette.base
        border.width: 1 //control.visualFocus ? 2 : 1
        border.color: (control.visualFocus||control.hovered)
                      ? _radioFocusColor
                      : control.checked
                        ? _radioCheckColor
                        : _radioNormalColor

        Rectangle {
            anchors.fill: parent
            anchors.margins: 5
            radius: control.radius<0 ? width/2 : control.radius
            color: parent.border.color
            visible: control.checked
        }
    }

    contentItem: CheckLabel {
        leftPadding: control.indicator && !control.mirrored
                     ? control.indicator.width + control.spacing
                     : 0
        rightPadding: control.indicator && control.mirrored
                      ? control.indicator.width + control.spacing
                      : 0

        text: control.text
        font: control.font
        color: (control.visualFocus||control.hovered)
               ? _textFocusColor
               : control.checked
                 ? _textCheckColor
                 : _textNormalColor
        renderType: Text.NativeRendering
    }
}
