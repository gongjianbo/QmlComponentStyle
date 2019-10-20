import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T

T.ToolButton {
    id: control

    property color textColor: (control.down || control.checked || control.highlighted || control.hovered) ? "cyan" : "white"
    property color buttonColor: (control.down || control.checked) ? "black": "transparent"
    //color: control.visualFocus ? control.palette.highlight : control.palette.buttonText

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 0
    leftPadding: 12
    rightPadding: 12
    spacing: 6

    //自定义的QmlIconLabel
    contentItem: QmlIconLabel {
        text: control.text
        font: control.font
        color: control.textColor
        spacing: control.spacing
        source: control.icon.source
    }

    background: Rectangle {
        implicitHeight: 30
        color: control.buttonColor
    }
}
