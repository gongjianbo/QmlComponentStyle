import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Shapes 1.12

//qtquickcontrols2\src\imports\controls\CheckBox.qml
//from Customizing CheckBox
T.CheckBox {
    id:control

    property color themeColor: "darkCyan"  //主题颜色
    property color textColor: "white"      //文本颜色
    property color indicatorColor: "white" //按钮颜色
    property Gradient _normalGradient: Gradient{
        GradientStop { position: 0.0; color: Qt.lighter(themeColor) }
        GradientStop { position: 0.5; color: themeColor }
        GradientStop { position: 1.0; color: Qt.lighter(themeColor) }
    }
    property Gradient _downGradient: Gradient{
        GradientStop { position: 0.0; color: Qt.darker(themeColor) }
        GradientStop { position: 0.5; color: themeColor }
        GradientStop { position: 1.0; color: Qt.lighter(themeColor) }
    }
    property Gradient _hoverGradient: Gradient{
        GradientStop { position: 0.0; color: themeColor }
        GradientStop { position: 0.5; color: Qt.darker(themeColor) }
        GradientStop { position: 1.0; color: themeColor }
    }

    implicitWidth: 90
    implicitHeight: 30
    leftPadding: 5
    rightPadding: 5

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

        /*Rectangle {

            color: indicatorColor
            antialiasing: false
            visible: control.checkState === Qt.Checked
        }*/
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
    contentItem: Text {
        text: control.text
        font: control.font
        //opacity: enabled ? 1.0 : 0.3
        //color: control.down ? "red" : "blue"
        color: textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        renderType: Text.NativeRendering
        elide: Text.ElideRight
        leftPadding: control.indicator.width + control.spacing +control.leftPadding
        rightPadding: control.rightPadding
    }

    background: Rectangle{
        radius: 3
        gradient: control.down
                    ? _downGradient
                    : control.hovered
                      ? _hoverGradient
                      : _normalGradient
    }
}
