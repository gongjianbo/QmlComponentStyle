import QtQuick 2.12
import QtQuick.Controls 2.12

//自定义loading效果
//龚建波 2022-02-08
Item {
    id: control

    //item的宽度
    property int itemWidth: 16
    //item的颜色
    property color itemColor: "#0486FF"
    //
    property double _rotate: _from
    property double _from: 30
    property double _to: 150
    //
    property bool running: visible

    implicitHeight: 160
    implicitWidth: 160

    //动画1旋转
    RotationAnimation {
        target: content
        from: 0
        to: 360
        loops: Animation.Infinite
        running: control.running
        duration: 3000
    }

    //动画2控制长度形变
    SequentialAnimation {
        loops: Animation.Infinite
        running: control.running
        NumberAnimation {
            target: control
            property: "_rotate"
            from: _from
            to: _to
            duration: 1000
        }
        NumberAnimation {
            duration: 1000 //停顿
        }
        NumberAnimation {
            target: control
            property: "_rotate"
            from: _to
            to: _from
            duration: 2000
        }
        NumberAnimation {
            duration: 3000 //停顿
        }
    }

    //半透明背景
    Rectangle {
        anchors.fill: parent
        anchors.margins: 2
        color: "transparent"
        border.width: control.itemWidth + 6
        border.color: control.itemColor
        opacity: 0.1
        radius: width / 2
    }
    Rectangle {
        anchors.fill: parent
        anchors.margins: 5
        color: "transparent"
        border.width: control.itemWidth
        border.color: control.itemColor
        opacity: 0.2
        radius: width / 2
    }

    //整体旋转
    Item {
        id: content
        anchors.fill: parent
        anchors.margins: 5

        //item 1
        Item {
            width: parent.width
            height: parent.height / 2
            clip: true

            Item {
                width: parent.width
                height: parent.height
                rotation: _rotate
                transformOrigin: Item.Bottom
                clip: true

                Rectangle {
                    width: content.width
                    height: content.height
                    color: "transparent"
                    border.width: control.itemWidth
                    border.color: control.itemColor
                    radius: width / 2
                }
            }
        }

        //item 2
        Item {
            y: parent.height / 2
            width: parent.width
            height: parent.height / 2
            clip: true

            Item {
                width: parent.width
                height: parent.height
                rotation: _rotate
                transformOrigin: Item.Top
                clip: true

                Rectangle {
                    y: -content.height / 2
                    width: content.width
                    height: content.height
                    color: "transparent"
                    border.width: control.itemWidth
                    border.color: control.itemColor
                    radius: width / 2
                }
            }
        }

        //端点四个
        Repeater {
            model: ListModel {
                ListElement { mul: 0; add: 90 }
                ListElement { mul: 1; add: -90 }
                ListElement { mul: 0; add: 270 }
                ListElement { mul: 1; add: 90 }
            }

            delegate: Rectangle {
                x: (content.width/2 - control.itemWidth/2) *
                   (1 + Math.sin((model.mul*_rotate+model.add)/360*6.283185307179))
                y: (content.height/2 - control.itemWidth/2) *
                   (1 - Math.cos((model.mul*_rotate+model.add)/360*6.283185307179))
                width: control.itemWidth
                height: width
                color: control.itemColor
                radius: width / 2
            }
        }
    }
}
