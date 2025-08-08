import QtQuick 2.15

// 自定义按钮
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

    // white:fff, black:000
    color: control_mousearea.pressed
           ? "#444"
           : control_mousearea.containsMouse
             ? "#888"
             : "#666"
    border {
        color: "black"
        width: 1
    }

    Text {
        id: control_text
        anchors.fill: parent
        text: qsTr("Button")
        color: control_mousearea.pressed ? "white" : "black"
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

    MouseArea {
        id: control_mousearea
        anchors.fill: parent
        hoverEnabled: true

        onEntered: control.entered()
        onExited: control.exited()
        onCanceled: control.canceled()
        onClicked: control.clicked()
        onDoubleClicked: control.doubleClicked()
        onPressAndHold: control.pressAndHold()
        onPressed: control.pressed()
        onReleased: control.released()
    }
}
