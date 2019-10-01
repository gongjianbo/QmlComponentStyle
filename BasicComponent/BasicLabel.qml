import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T

//Label继承自Text，而Text是支持Html样式的
T.Label {
    id: control

    property bool underlineVisible: false
    property color normalColor: "black"
    property color hoverColor: "blue"

    padding: 3
    color: mouse_area.hovered?hoverColor:normalColor;
    font{
        family: "SimSun"
        pixelSize: 16
    }
    renderType: Text.NativeRendering
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    //wrapMode: Text.NoWrap
    elide: Text.ElideRight
    //linkColor: control.palette.link
    Rectangle{
        visible: control.underlineVisible
        width: parent.width
        height: 1
        color: control.color
        anchors.bottom: parent.bottom
    }
    MouseArea{
        id: mouse_area
        anchors.fill: parent
        hoverEnabled: true
        property bool hovered: false
        onEntered: hovered=true;
        onExited: hovered=false;
    }
}
