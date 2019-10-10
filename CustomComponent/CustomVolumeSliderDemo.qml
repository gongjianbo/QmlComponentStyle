import QtQuick 2.12

//音量调节展示
Rectangle{
    id: control
    width: 100
    height: 300
    color: "black"
    rotation: 0
    Column{
        anchors.centerIn: parent
        spacing: 16
        //把slider和image拆分开是为了之后可以做成一个按钮式的
        //点击image再弹slider出来
        CustomVolumeSlider{
            anchors.horizontalCenter: parent.horizontalCenter
            slider{
                from:0
                to:100
                stepSize: 1
                value: 45
            }
        }
        //Image from
        //https://www.iconfont.cn/collections/detail?spm=a313x.7781069.0.da5a778a4&cid=328
        Image {
            width: 32
            height: 32
            rotation: -control.rotation
            //找这个icon是左对齐的，心塞
            //我只下了这一个图，本来有好几个状态
            //anchors.horizontalCenterOffset: 10
            anchors.horizontalCenter: parent.horizontalCenter
            source: "qrc:/volume-medium.png"
        }
    }
}
