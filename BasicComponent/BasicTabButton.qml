import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T

T.TabButton {
    id: control

    property color textColor: (control.checked||control.hovered) ? "cyan" : "white"
    property color buttonColor: control.checked ? "black": "gray"

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 0
    leftPadding: 12
    rightPadding: 12
    spacing: 6
    font{
        family: "SimSun"
        pixelSize: 16
    }

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
        height: control.height - 1
        color: control.buttonColor
    }
}
