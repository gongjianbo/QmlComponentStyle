import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T

T.ToolButton {
    id: control

    property color textColor: (control.down || control.checked || control.highlighted || control.hovered) ? "cyan" : "white"
    property color buttonColor: (control.down || control.checked) ? "black": "transparent"

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6

    contentItem: Text {
        text: control.text
        font: control.font
        color: control.textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        renderType: Text.NativeRendering
        elide: Text.ElideRight
        //color: control.visualFocus ? control.palette.highlight : control.palette.buttonText
    }

    background: Rectangle {
        implicitHeight: 30
        color: control.buttonColor
    }
}
