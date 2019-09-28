import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Shapes 1.12

//qtquickcontrols2\src\imports\controls\CheckBox.qml
//from Customizing CheckBox
T.CheckBox {
    id:control

    //可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    property color textColor: "white"          //文字颜色
    property color backgroundColor: "darkCyan" //背景颜色
    property color _bgNormalColor: backgroundColor               //普通状态背景颜色
    property color _bgCheckColor: Qt.darker(backgroundColor)     //选中背景颜色
    property color _bgHoverColor: Qt.lighter(backgroundColor)    //悬停背景颜色
    property color _bgDownColor: Qt.darker(backgroundColor)      //按下背景颜色
    property color indicatorColor: "white"     //勾选框颜色
    property int radius: 0

    implicitWidth: 90
    implicitHeight: 30
    leftPadding: 5
    rightPadding: 5
    spacing: 5
    font{
        family: "SimSun"
        pixelSize: 16
    }

    //勾选框，用贴图更方便
    indicator: Rectangle {
        implicitWidth: control.height-2*control.leftPadding
        implicitHeight: width
        x: control.leftPadding
        y: (parent.height-height) / 2
        color: "transparent"
        border.width: 1
        border.color: indicatorColor
        antialiasing: false

        //源码中是用ColorImage加载的按钮图标
        Shape { //indicator全部用shape算了
            id: checked_indicator
            anchors.centerIn: parent
            width: parent.width-6
            height: parent.height-6
            visible: control.checkState === Qt.Checked
            //smooth: true //平滑处理
            //antialiasing: true //反走样抗锯齿
            ShapePath {
                strokeWidth: 2
                strokeColor: indicatorColor
                //fillRule: ShapePath.WindingFill
                fillColor: "transparent"
                startX: 0; startY: checked_indicator.height/2
                PathLine { x:checked_indicator.width/2; y:checked_indicator.height }
                PathLine { x:checked_indicator.width; y:0 }
            }
        }
        Rectangle {
            anchors.centerIn: parent
            width: parent.width/2
            height: parent.height/2
            color: indicatorColor
            antialiasing: false
            visible: control.checkState === Qt.PartiallyChecked
        }
    }

    //勾选框文本
    contentItem: CheckLabel {
        text: control.text
        font: control.font
        color: textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        renderType: Text.NativeRendering
        elide: Text.ElideRight
        leftPadding: control.indicator.width + control.spacing +control.leftPadding
        rightPadding: control.rightPadding
    }

    background: Rectangle{
        radius: control.radius
        color: control.checked
               ? _bgCheckColor
               : control.down
                 ? _bgDownColor
                 : control.hovered
                   ? _bgHoverColor
                   : _bgNormalColor
    }
}
