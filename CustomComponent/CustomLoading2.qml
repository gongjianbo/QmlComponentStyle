import QtQuick 2.12
import QtQuick.Controls 2.12

//自定义 loading 效果
//目前角度是设定死的，可以根据直径算
//龚建波 2021-1-17
Item {
    id: control

    //item圆圈个数
    property int itemCount: 4
    //item圆圈直径
    property int itemSize: 20
    //item圆圈颜色
    property color itemColor: "green"
    //转一次时长
    property int duration: 3000
    //
    property bool running: visible

    implicitHeight: 160
    implicitWidth: 160

    Item{
        id: content
        anchors.fill: parent
        anchors.margins: 5

        Repeater{
            id: repeater
            model: control.itemCount

            //长方形wrapper用来旋转
            Item{
                id: wrapper
                width: control.itemSize
                height: content.height
                x: content.width/2-width/2
                //todo 目前角度是设定死的，可以根据直径算
                rotation: -index*20

                //动画序列，根据顺序做了间隔
                SequentialAnimation {
                    running: control.running
                    loops: Animation.Infinite
                    NumberAnimation{
                        duration: index*100
                    }
                    ParallelAnimation{
                        RotationAnimation{
                            target: wrapper
                            from: -index*20
                            to: 360-index*20
                            duration: control.duration
                            easing.type: Easing.OutCubic
                        }
                        SequentialAnimation{
                            NumberAnimation{
                                target: item
                                property: "opacity"
                                from: 0
                                to: 1
                                duration: control.duration*1/8
                            }
                            NumberAnimation{
                                duration: control.duration*3/4
                            }
                        }
                    }
                    NumberAnimation{
                        duration: (control.itemCount-index)*100
                    }
                }

                //小圆圈
                Rectangle{
                    id: item
                    height: control.itemSize
                    width: height
                    radius: height/2
                    color: control.itemColor
                }
            }
        }
    }
}
