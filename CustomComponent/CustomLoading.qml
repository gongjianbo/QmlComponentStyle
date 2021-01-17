import QtQuick 2.12
import QtQuick.Controls 2.12

//自定义 loading 效果
//龚建波 2021-1-17
Item {
    id: control

    //item圆圈个数
    property int itemCount: 10
    //item圆圈直径大小
    property int itemSize: 16
    //item变大范围
    property int itemExpand: 10
    //当前item，配合动画
    property int itemIndex: 0
    //轮转一次的时长
    property int duration: 1500
    //
    property bool running: visible

    implicitHeight: 160
    implicitWidth: 160

    //index从0到count轮转，转到对应item就变大且不透明
    //animation也可以换成timer
    NumberAnimation{
        target: control
        property: "itemIndex"
        from: 0
        to: control.itemCount-1
        loops: Animation.Infinite
        duration: control.duration
        running: control.running
    }

    //加一层item.margin来容纳item大小变化
    Item{
        id: content
        anchors.fill: parent
        anchors.margins: control.itemExpand/2+1

        Repeater{
            id: repeater
            model: control.itemCount
            Rectangle{
                id: item
                height: control.itemSize
                width: height
                x: content.width/2 - width/2
                y: content.height/2 - height/2
                radius: height/2
                color: "green"

                //环绕在中心
                transform: [
                    Translate {
                        y: content.height/2-height/2
                    },
                    Rotation {
                        angle: index / repeater.count * 360
                        origin.x: width/2
                        origin.y: height/2
                    }
                ]

                //轮转到当前item时就切换状态
                state: control.itemIndex===index?"current":"normal"
                states: [
                    State {
                        name: "current"
                        PropertyChanges {
                            target: item
                            opacity: 1
                            height: control.itemSize+control.itemExpand
                        }
                    },
                    State {
                        name: "normal"
                        PropertyChanges {
                            target: item
                            opacity: 0.1
                            height: control.itemSize
                        }
                    }
                ]

                //大小和透明度的状态过渡
                transitions: [
                    Transition {
                        from: "current"
                        to: "normal"
                        NumberAnimation{
                            properties: "opacity,height"
                            duration: control.duration
                        }
                    },
                    Transition {
                        from: "normal"
                        to: "current"
                        NumberAnimation{
                            properties: "opacity,height"
                            duration: 0
                        }
                    }
                ]
            }
        }
    }
}
