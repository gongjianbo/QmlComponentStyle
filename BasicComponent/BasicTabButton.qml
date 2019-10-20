import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T

T.TabButton {
    id: control

    property color textColor: (control.checked||control.hovered) ? "cyan" : "white"
    property color buttonColor: control.checked ? "black": "gray"
    property color indicatorColor: "black"
    property color arrowColor: "black"

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6
    font{
        family: "SimSun"
        pixelSize: 14
    }

    contentItem: Text {
        text: control.text
        font: control.font
        color: control.textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        renderType: Text.NativeRendering
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitHeight: 30
        height: control.height - 1
        color: control.buttonColor
    }
}
