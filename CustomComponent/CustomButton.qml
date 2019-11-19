import QtQuick 2.12

Rectangle {
    id:control

    property alias text: control_text.text
    property alias font: control_text.font
    property alias textColor: control.color
    property alias content: control_text
    property alias mousearea: control_mousearea

    signal entered()
    signal exited()
    signal canceled()
    signal clicked()
    signal doubleClicked()
    signal pressAndHold()
    signal pressed()
    signal released()

    implicitWidth: 90
    implicitHeight: 30

    //white:fff, black:000
    color: control_mousearea.down_state
           ?"#444"
           :control_mousearea.hover_state
             ?"#888"
             :"#666"
    border {
        color: "black"
        width: 1
    }

    Text {
        id: control_text
        anchors.fill: parent
        text: qsTr("Button")
        color: control_mousearea.down_state?"white":"black"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        renderType: Text.NativeRendering
        elide: Text.ElideRight
        padding: 5
        font {
            family: "SimSun"
            pixelSize: 16
        }
    }

    MouseArea{
        id: control_mousearea
        anchors.fill: parent
        hoverEnabled: true
        property bool hover_state: false
        property bool down_state: false

        onEntered: {
            hover_state=true;
            control.entered();
        }
        onExited: {
            hover_state=false;
            control.exited();
        }
        onCanceled: control.canceled();
        onClicked: {
            control.clicked();
        }
        onDoubleClicked: {
            control.doubleClicked();
        }
        onPressAndHold: {
            down_state=true;
            control.pressAndHold();
        }
        onPressed: {
            down_state=true;
            control.pressed();
        }
        onReleased: {
            down_state=false;
            control.released();
        }
    }
}
