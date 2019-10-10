import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

//音量调节Slider
Rectangle {
    id:volume
    implicitWidth: 50
    implicitHeight: 200
    radius: width*2/5
    color: Qt.rgba(80/255,80/255,80/255,1)
    property alias slider: control

    Slider{
        id: control
        anchors.centerIn: parent
        implicitWidth: horizontal? 180: 6;
        implicitHeight: horizontal? 6: 180;
        orientation:Qt.Vertical
        padding: 0

        background: Rectangle {
            implicitWidth: control.implicitWidth
            implicitHeight: control.implicitHeight
            color: "#25282a"
            //radius: 2

            Rectangle {
                y: control.horizontal ? 0 : control.visualPosition * parent.height
                width: control.horizontal ? control.position * parent.width : parent.width
                height: control.horizontal ? parent.height : control.position * parent.height
                color: "#2674e8"
                //radius: 2
            }
        }

        //这个拖动按钮可以找个图片替换
        handle: Item {
            x: control.leftPadding + (control.horizontal ? control.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
            y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.visualPosition * (control.availableHeight - height))
            //width: control.horizontal?control.height:control.width
            //height: control.horizontal?control.height:control.width
            implicitWidth: 12
            implicitHeight: 12
            Rectangle{
                id:rect_out
                anchors.fill: parent
                radius: width/2
                color:Qt.rgba(175/255,175/255,175/255,1)
                Rectangle{
                    id:rect_in
                    anchors.centerIn: parent
                    width: parent.width/3
                    height: width
                    radius: width/2
                    color:Qt.rgba(80/255,80/255,80/255,1)
                }
            }
            DropShadow{
                id:shadow_out
                anchors.fill: rect_out
                source: rect_out
                horizontalOffset: -2
                verticalOffset: 2
                color: "#25282a"
            }
        }
    }
    MouseArea{
        anchors.fill: parent
        //避免和handle冲突
        acceptedButtons: Qt.NoButton
        onWheel: {
            if(wheel.angleDelta.y<0){
                control.decrease();
            }else{
                control.increase();
            }
        }
    }
}
