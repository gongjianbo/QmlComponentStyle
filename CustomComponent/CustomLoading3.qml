import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Shapes 1.12

//自定义loading效果
//龚建波 2022-02-09
Item {
    id: control

    implicitWidth: 160
    implicitHeight: 160

    property int itemMargin: 5
    property int itemBorder: 4
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

    //动画1旋转
    RotationAnimation {
        target: sp
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
            duration: 2000
        }
        NumberAnimation {
            duration: 2000 //停顿
        }
        NumberAnimation {
            target: control
            property: "_rotate"
            from: _to
            to: _from
            duration: 1000
        }
        NumberAnimation {
            duration: 2000 //停顿
        }
    }

    Shape {
        id: sp
        width: control.width
        height: control.height
        layer{
            enabled: true
            smooth: true
            samples: 16
        }

        //底部浅色
        ShapePath {
            strokeWidth: itemWidth+itemBorder*2
            strokeColor: Qt.lighter(itemColor, 1.9)
            strokeStyle: ShapePath.SolidLine
            fillColor: "transparent"

            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin

            PathAngleArc {
                centerX: width/2
                centerY: height/2
                radiusX: width/2-itemWidth/2-itemMargin-itemBorder
                radiusY: height/2-itemWidth/2-itemMargin-itemBorder
                startAngle: 0
                sweepAngle: 360
                moveToStart: true
            }
        }

        //底部深色
        ShapePath {
            strokeWidth: itemWidth
            strokeColor: Qt.lighter(itemColor, 1.8)
            strokeStyle: ShapePath.SolidLine
            fillColor: "transparent"

            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin

            PathAngleArc {
                centerX: width/2
                centerY: height/2
                radiusX: width/2-itemWidth/2-itemMargin-itemBorder
                radiusY: height/2-itemWidth/2-itemMargin-itemBorder
                startAngle: 0
                sweepAngle: 360
                moveToStart: true
            }
        }

        //旋转的曲线
        ShapePath {
            strokeWidth: itemWidth
            strokeColor: itemColor
            strokeStyle: ShapePath.SolidLine
            fillColor: "transparent"

            capStyle: ShapePath.RoundCap
            joinStyle: ShapePath.RoundJoin

            PathAngleArc {
                centerX: width/2
                centerY: height/2
                radiusX: width/2-itemWidth/2-itemMargin-itemBorder
                radiusY: height/2-itemWidth/2-itemMargin-itemBorder
                startAngle: 0
                sweepAngle: -_rotate
                moveToStart: true
            }

            PathAngleArc {
                centerX: width/2
                centerY: height/2
                radiusX: width/2-itemWidth/2-itemMargin-itemBorder
                radiusY: height/2-itemWidth/2-itemMargin-itemBorder
                startAngle: 180
                sweepAngle: -_rotate
                moveToStart: true
            }
        }
    }
}
