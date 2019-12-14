import QtQuick 2.12

//轮播图展示
Item {
    id:control
    width: 300
    height: 100
    CustomCircularView{
        anchors.fill: parent
        model: ["red","green","blue","yellow","purple"]
        delegate: Rectangle{
            width: control.width
            height: control.height
            color: modelData
        }
    }
}
