import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T

T.AbstractButton {
    id: control

    text: qsTr("Button")
    property color textColor: down?"white":"black"
    property color color: down
           ?"#444"
           :hovered
             ?"#888"
             :"#666"
    property color borderColor: "black"

    implicitWidth: 90
    implicitHeight: 30

    font {
        family: "SimSun"
        pixelSize: 16
    }

    contentItem: Text {
        text: control.text
        color: control.textColor
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        renderType: Text.NativeRendering
        elide: Text.ElideRight
        padding: 5
        font: control.font
    }

    background: Rectangle{
        color: control.color
        border.color: borderColor
    }
}
