import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T

//qtquickcontrols2\src\imports\controls\RadioButton.qml
//from Customizing RadioButton
T.RadioButton {
    id: control

    //只是把源码里的颜色改了下
    property color textColor: (control.visualFocus||control.hovered)
                              ? Qt.lighter(radioTheme)
                              : control.checked
                                ? radioTheme
                                : radioTheme
    property color radioTheme: "darkCyan"
    property color radioColor: (control.visualFocus||control.hovered)
                               ? Qt.lighter(radioTheme)
                               : control.checked
                                 ? radioTheme
                                 : radioTheme

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
        border.color: control.radioColor

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
        color: control.textColor
        renderType: Text.NativeRendering
    }
}
