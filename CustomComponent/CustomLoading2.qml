import QtQuick 2.12
import QtQuick.Controls 2.12

//自定义 loading 效果
//目前角度是设定死的，可以根据直径算
//龚建波 2021-1-17
//2021-2-11代码优化
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
        anchors.margins: 5 + control.itemSize/2

        Repeater{
            id: repeater
            model: control.itemCount

            //旋转的小球
            Rectangle{
                id: item
                width: control.itemSize
                height: control.itemSize
                color: control.itemColor
                radius: width/2
                //[1].圆边上点坐标计算公式（角度从右端逆时针增长）
                //x1 = x0 + r * cos(angle * PI / 180)
                //y1 = y0 + r * sin(angle * PI /180)
                //[2].js Math用的弧度
                //1弧度bai=180/pai 度
                //1度=pai/180 弧度
                //[3].Qt是屏幕坐标系，所以y值取反一下
                //y1 = y0 - r * sin(angle * PI /180)
                //再把相位调到90度从顶上开始转，这样三角函数可以简化下
                //sin（π/2＋α）＝cosα
                //cos（π/2＋α）＝-sinα
                //于是有了
                //x1 = x0 - r * sin(angle * PI / 180)
                //y1 = y0 - r * cos(angle * PI /180)
                //[4].此时逐渐增大角度就是逆时针转的，想要顺时针转又得再取反一次坐标
                //或者改为逐渐减小
                //我选择取反x
                //x1 = x0 + r * sin(angle * PI / 180)
                //[5].最后把小球的半径偏移去掉，就是围绕圆心转的效果了
                //不然默认起点为左上角，会往右下角偏离一点
                //（我把wrapper的margin加了size/2，这样就不用减掉半径放值越界了）
                x: content.width/2 - control.itemSize/2 + content.width/2 * Math.sin(rotate/360*6.283185307179)
                y: content.height/2 - control.itemSize/2 - content.height/2 * Math.cos(rotate/360*6.283185307179)
                //rotate表示角度，范围[0,360]，初始值目前为固定的
                property real rotate: -index*20


                //动画序列，根据顺序做了间隔
                SequentialAnimation {
                    running: control.running
                    loops: Animation.Infinite
                    NumberAnimation{
                        duration: index*100
                    }
                    ParallelAnimation{
                        NumberAnimation{
                            target: item
                            property: "rotate"
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
            }
        }
    }
}
