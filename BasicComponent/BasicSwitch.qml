import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12

T.Switch {
    id: control
    property color textColor: "black"
    property color indicatorTheme: "darkCyan"
    property color indicatorBgColor: control.checked?Qt.darker(indicatorTheme):Qt.lighter(indicatorTheme)
    property color indicatorBorderColor: indicatorTheme
    property color indicatorButtonColor: control.down?Qt.lighter(indicatorTheme):"white"

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6
    font{
        family: "SimSun"
        pixelSize: 14
    }

    indicator: PaddedRectangle {
        implicitWidth: 56
        implicitHeight: 28

        x: text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2

        radius: 8
        leftPadding: 0
        rightPadding: 0
        padding: (height - 16) / 2
        color: control.indicatorBgColor

        Rectangle {
            x: Math.max(0, Math.min(parent.width - width, control.visualPosition * parent.width - (width / 2)))
            y: (parent.height - height) / 2
            width: 28
            height: 28
            radius: 14
            color: control.indicatorButtonColor
            border.width: control.visualFocus ? 2 : 1
            //border.color: control.visualFocus ? control.palette.highlight : control.enabled ? control.palette.mid : control.palette.midlight
            border.color: control.indicatorBorderColor

            Behavior on x {
                enabled: !control.down
                SmoothedAnimation { velocity: 200 }
            }
        }
    }

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
