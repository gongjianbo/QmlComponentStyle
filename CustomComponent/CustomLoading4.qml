import QtQuick 2.15
import QtQuick.Controls 2.15

// 自定义loading效果
// 龚建波 2022-02-08
Item {
    id: control

    // item的颜色
    property color itemColor: "#0486FF"
    // 当前旋转的x轴还是y轴
    property int _transX: 0
    // 当前旋转的角度，0-180后切换到另一个轴旋转
    property double _transRotate: 0
    //
    property bool running: visible

    implicitHeight: 160
    implicitWidth: 160

    // 动画
    SequentialAnimation {
        loops: Animation.Infinite
        running: control.running
        NumberAnimation {
            target: control
            property: "_transRotate"
            from: 0
            to: 180
            duration: 1000
        }
        NumberAnimation {
            target: control
            property: "_transX"
            from: 0
            to: 1
            duration: 200
        }
        NumberAnimation {
            target: control
            property: "_transRotate"
            from: 180
            to: 0
            duration: 1000
        }
        NumberAnimation {
            target: control
            property: "_transX"
            from: 1
            to: 0
            duration: 200
        }
    }

    Item {
        id: content
        anchors.fill: parent
        anchors.margins: 8

        // 翻转的方块
        Rectangle {
            id: rect
            width: content.width
            height: content.height
            color: control.itemColor
            antialiasing: true
            transform: [
                Rotation {
                    angle: control.running ? control._transRotate : 0
                    axis{
                        x: control._transX ? 1 : 0
                        y: control._transX ? 0 : 1
                        z: 0
                    }
                    origin{
                        x: rect.width / 2
                        y: rect.height / 2
                    }
                }
            ]
        }
    }
}
