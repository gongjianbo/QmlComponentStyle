import QtQuick 2.12

//滑动按钮
//qml圆角抗锯齿有点糊，索性去掉
Rectangle {
    id: control

    property color offBorderColor: "black"
    property color offButtonColor: "white"
    property color offBackgroundColor: "gray"
    property color onBorderColor: Qt.darker("green")
    property color onButtonColor: Qt.lighter("green")
    property color onBackgroundColor: "green"

    implicitWidth: 90
    implicitHeight: 30

    radius: height/2
    border.width: 0

    Rectangle{
        id: switch_button
        height: parent.height
        width: parent.width*2/3
        radius: height/2
        border.color: parent.color
        border.width: 2
        //本来想加个Off/On的文本在上面，貌似没必要
    }

    MouseArea{
        anchors.fill: parent
        onClicked: {
            control.state=(control.state=="off")?"on":"off";
        }
    }

    state: "off"
    states: [
        State {
            name: "off"
            PropertyChanges {
                target: control
                border.color: offBorderColor
                color: offBackgroundColor
            }
            PropertyChanges {
                target: switch_button
                color: offButtonColor
                x: 0
            }
        },
        State {
            name: "on"
            PropertyChanges {
                target: control
                border.color: onBorderColor
                color: onBackgroundColor
            }
            PropertyChanges {
                target: switch_button
                color: onButtonColor
                x: control.width-switch_button.width
            }
        }
    ]

    transitions: [
        Transition {
            from: "off"
            to: "on"
            //按钮加渐变过渡感觉很奇怪，参照手机上的按钮就没加渐变动画
            //ColorAnimation { targets: [control]; duration: 300 }
            NumberAnimation { targets: [switch_button]; property: "x"; duration: 300 }
        },
        Transition {
            from: "on"
            to: "off"
            //ColorAnimation { targets: [control]; duration: 200 }
            NumberAnimation { targets: [switch_button]; property: "x"; duration: 200 }
        }
    ]
}
