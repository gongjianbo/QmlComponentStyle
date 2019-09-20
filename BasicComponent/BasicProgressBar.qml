import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12

//qtquickcontrols2\src\imports\controls\ProgressBar.qml
//from Customizing ProgressBar
T.ProgressBar {
    id: control

    property color backgroundColor: Qt.rgba(0.7,0.7,0.7)
    property color foregroundColor: "darkCyan"
    property Gradient _backgroundGradient: Gradient{
        GradientStop { position: 0.0; color: Qt.lighter(backgroundColor) }
        GradientStop { position: 0.8; color: backgroundColor }
    }
    property Gradient _foregroundGradient: Gradient{
        GradientStop { position: 0.2; color: Qt.lighter(foregroundColor) }
        GradientStop { position: 1.0; color: foregroundColor }
    }

    implicitWidth: 200
    implicitHeight: 10
    //clip: true
    //底部背景
    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 6
        radius: height/2
        gradient: _backgroundGradient
    }
    //进度条
    contentItem:Loader{
        //分为普通滚动条和indeterminate模糊模式进度条
        //模糊模式，即没有具体值
        sourceComponent: control.indeterminate?indeterminate_comp:normal_comp
        Component{
            id: indeterminate_comp
            Item{
                //后期需要做成多个小球的样式
                Rectangle{
                    id: indeterminate_bar
                    height: parent.height
                    width: parent.width/4
                    radius: height/2
                    gradient: _foregroundGradient
                    SequentialAnimation on x {
                        loops: Animation.Infinite
                        PropertyAnimation{
                            from:0; to:(control.width-indeterminate_bar.width)/2;
                            duration: 2000
                            easing.type: Easing.OutQuad
                        }
                        PauseAnimation {
                            duration: 500
                        }
                        PropertyAnimation{
                            from:(control.width-indeterminate_bar.width)/2; to:control.width-indeterminate_bar.width;
                            duration: 2000
                            easing.type: Easing.InQuad
                        }
                    }
                }

            }
        } //end comp

        Component{
            id: normal_comp
            Item {
                Rectangle{
                    width: control.visualPosition * parent.width
                    height: parent.height
                    radius: height/2
                    gradient: _foregroundGradient
                    SequentialAnimation on opacity {
                        loops: Animation.Infinite
                        PropertyAnimation{ from:0.3; to:1.0; duration: 2000 }
                        PropertyAnimation{ from:1.0; to:0.3; duration: 1000 }
                    }
                }
            }
        } //end comp
    }
}
