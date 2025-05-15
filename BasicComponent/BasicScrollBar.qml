import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T

//qtquickcontrols2\src\imports\controls\ScrollBar.qml
//from Customizing ScrollBar
T.ScrollBar {
    id: control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    property color themeColor: "darkCyan"
    property color handleNormalColor: themeColor  //按钮颜色
    property color handleHoverColor: Qt.lighter(themeColor)
    property color handlePressColor: Qt.darker(themeColor)

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 1 //背景整体size和handle的间隔
    visible: control.policy !== T.ScrollBar.AlwaysOff

    contentItem: Rectangle {
        implicitWidth: control.interactive ? 10 : 2
        implicitHeight: control.interactive ? 10 : 2

        radius: width / 2
        color: control.pressed
               ?handlePressColor
               :control.hovered
                 ?handleHoverColor
                 :handleNormalColor
        //修改为widgets那种alwayson/超出范围才显示的样子
        opacity:(control.policy === T.ScrollBar.AlwaysOn || control.size < 1.0)?1.0:0.0
        //默认行为ScrollBar.AsNeeded是鼠标放上去或者滚动滚轮才会出现滚动条
        //我把它改成了widgets那种超出范围就一直显示的样式
        //如果想用原本的样式，可以使用下面被注释的代码，它来自源码
        /*opacity: 0.0
        states: State {
            name: "active"
            when: control.policy === T.ScrollBar.AlwaysOn || (control.active && control.size < 1.0)
            PropertyChanges { target: control.contentItem; opacity: 0.75 }
        }
        transitions: Transition {
            from: "active"
            SequentialAnimation {
                PauseAnimation { duration: 450 }
                NumberAnimation { target: control.contentItem; duration: 200; property: "opacity"; from:1.0; to: 0.0 }
            }
        }*/
    }
    //一般不需要背景
    /*background: Rectangle{
        implicitWidth: control.interactive ? 10 : 2
        implicitHeight: control.interactive ? 10 : 2
        color: "skyblue"
        //opacity: 0.3
    }*/
}
