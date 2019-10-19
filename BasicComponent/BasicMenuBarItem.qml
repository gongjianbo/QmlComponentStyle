import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12

T.MenuBarItem {
    id: control

    property color textColor: control.highlighted ? "cyan" : "white"
    property color backgroundColor: control.down || control.highlighted ? "black" : "gray"

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    //spacing: 6
    padding: 0
    leftPadding: 12
    rightPadding: 12

    //icon.width: 24
    //icon.height: 24
    //icon.color: control.palette.buttonText

    contentItem: Text {
        text: control.text
        font: control.font
        //opacity: enabled ? 1.0 : 0.3
        color: control.textColor
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        renderType: Text.NativeRendering
        elide: Text.ElideRight
    }

    background: Rectangle {
        implicitWidth: 30
        implicitHeight: 30
        color: control.backgroundColor
    }
}
