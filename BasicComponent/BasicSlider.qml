import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T

//qtquickcontrols2\src\imports\controls\Slider.qml
//from Customizing Slider
T.Slider {
    id: control

    //本来想在原来的基础上增加个opposite direction相反方向的属性
    //奈何handle是和鼠标判定区域挂钩的，所以要做这个的话就不能用原来的handle
    //相当于自己重新组合一个slider控件
    property color handleBorderColor: "black"     //按钮边框颜色
    property color handleNormalColor: "darkCyan"  //按钮颜色
    property color handleHoverColor: Qt.lighter(handleNormalColor)
    property color handlePressColor: Qt.darker(handleNormalColor)
    property color completeColor: "cadetblue"
    property color incompleteColor: "powderblue"

    /*implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitHandleHeight + topPadding + bottomPadding)*/

    implicitWidth: horizontal? 200: 24;
    implicitHeight: horizontal? 24: 200;
    //padding把长条背景挤压
    padding: horizontal? height/4: width/4;

    handle: Rectangle {
        x: control.leftPadding + (control.horizontal ? control.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.visualPosition * (control.availableHeight - height))
        width: control.horizontal?(control.height/2):(control.width)
        height: control.horizontal?(control.height):(control.width/2)
        //radius: width/2  //感觉方形比原型更协调点，或许也可以用圆角矩形那种scrollbar的样式
        color: control.pressed
               ?handlePressColor
               :control.hovered
                 ?handleHoverColor
                 :handleNormalColor
        border.width: 1
        border.color: handleBorderColor
    }

    background: Rectangle {
        //以control.horizontal为例：
        //control.availableHeight为去掉padding的高度
        //所以如果control很高的话，只根据padding来算y可能就贴着上面
        //这时候就需要加一部分(control.availableHeight - height) / 2来对齐
        x: control.leftPadding + (control.horizontal ? 0 : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : 0)
        implicitWidth: control.horizontal ? 200 : 6
        implicitHeight: control.horizontal ? 6 : 200
        width: control.horizontal ? control.availableWidth : implicitWidth
        height: control.horizontal ? implicitHeight : control.availableHeight
        radius: 3
        color: control.incompleteColor
        scale: control.horizontal && control.mirrored ? -1 : 1

        //用另一个方块分别已完成和未完成的颜色
        Rectangle {
            y: control.horizontal ? 0 : control.visualPosition * parent.height
            width: control.horizontal ? control.position * parent.width : parent.width
            height: control.horizontal ? parent.height : control.position * parent.height
            radius: 3
            color: control.completeColor
        }
    }
}
