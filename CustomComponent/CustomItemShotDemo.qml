import QtQuick 2.12
import QtQuick.Controls 2.12

//截图展示
Rectangle {
    id: control

    width: 300
    height: 300

    Rectangle{
        id: target
        anchors.fill: parent
        anchors.topMargin: 30
        border.width: 50
        border.color: "purple"
        color: "orange"

        Rectangle{
            width: 80
            height: 200
            anchors.centerIn: parent
            color: "cyan"
        }
    }

    //对Item截图
    CustomItemShot{
        id: shot_area
        shotTarget: target //要抓取的Item
        anchors.fill: target //范围
        anchors.margins: 1
        visible: false
    }

    Button{
        width: 90
        height: 30
        text: "Shot"
        onClicked: {
            if(shot_area.visible){
                shot_area.close();
            }else{
                shot_area.pop();
            }
        }
    }
}
