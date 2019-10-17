import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T

//qtquickcontrols2\src\imports\controls\DelayButton.qml
//from Customizing DelayButton
T.DelayButton {
    id: control

    property color backgroundColor: "darkCyan"  //按钮背景色
    property color maskColor: "green"           //遮罩颜色
    property color uncheckTextColor: "white"    //未选中文本颜色
    property color checkedTextColor: "cyan"     //选中文本颜色
    property int radius: 0

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 6
    horizontalPadding: padding + 2
    font{
        family: "SimSun"
        pixelSize: 16
    }

    transition: Transition {
        NumberAnimation {
            duration: control.delay * (control.pressed ? 1.0 - control.progress : 0.3 * control.progress)
        }
    }

    contentItem: ItemGroup {
        ClippedText {
            clip: control.progress > 0
            clipX: -control.leftPadding + control.progress * control.width
            clipWidth: (1.0 - control.progress) * control.width
            visible: control.progress < 1

            text: control.text
            font: control.font
            //opacity: enabled ? 1 : 0.3
            color: uncheckTextColor
            renderType: Text.NativeRendering
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }

        ClippedText {
            clip: control.progress > 0
            clipX: -control.leftPadding
            clipWidth: control.progress * control.width
            visible: control.progress > 0

            text: control.text
            font: control.font
            //opacity: enabled ? 1 : 0.3
            color: checkedTextColor
            renderType: Text.NativeRendering
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideRight
        }
    }

    background: Rectangle {
        implicitWidth: 120
        implicitHeight: 30
        //color: control.down ? "orange" : "green"
        //border.width: control.visualFocus ? 1 : 0
        radius: control.radius
        color: control.hovered
               ? Qt.lighter(control.backgroundColor)
               : control.backgroundColor

        //progress mask按下时的遮罩
        PaddedRectangle {
            radius: control.radius
            width: control.progress * parent.width
            height: parent.height
            color: control.hovered
                   ? Qt.lighter(control.maskColor)
                   : control.maskColor
        }
    }
}
