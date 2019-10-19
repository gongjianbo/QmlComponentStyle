import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Shapes 1.12

T.MenuItem {
    id: control

    property color textColor: control.highlighted ? "cyan" : "black"
    property color menuColor: control.down ? "black": control.highlighted ? "gray": "transparent"
    property color indicatorColor: "black"
    property color arrowColor: "black"

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 0
    spacing: 6

    contentItem: Text {
        readonly property real arrowPadding: control.subMenu && control.arrow ? control.arrow.width + control.spacing : 0
        readonly property real indicatorPadding: control.checkable && control.indicator ? control.indicator.width + control.spacing : 0
        readonly property real left_pd: !control.mirrored ? indicatorPadding : arrowPadding
        //没有边距就贴在边上了
        leftPadding: left_pd<=0?6:left_pd
        rightPadding: control.mirrored ? indicatorPadding : arrowPadding

        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        renderType: Text.NativeRendering
        text: control.text
        font: control.font
        color: control.textColor
    }

    indicator: Item {
        x: control.mirrored ? control.width - width - control.rightPadding : control.leftPadding
        //y: control.topPadding + (control.availableHeight - height) / 2
        implicitWidth: 30
        implicitHeight: 30
        Rectangle {
            width: parent.width-8
            height: width
            anchors.centerIn: parent
            visible: control.checkable
            border.width: 1
            border.color: control.indicatorColor
            Rectangle {
                width: parent.width-8
                height: width
                anchors.centerIn: parent
                visible: control.checked
                color: control.indicatorColor
            }
        }
    }

    arrow: Shape {
        id: item_arrow
        x: control.mirrored ? control.leftPadding : control.width - width - control.rightPadding
        //y: control.topPadding + (control.availableHeight - height) / 2
        visible: control.subMenu
        implicitWidth: 30
        implicitHeight: 30
        ShapePath {
            strokeWidth: 0
            strokeColor: control.arrowColor
            fillRule: ShapePath.WindingFill
            fillColor: control.arrowColor
            startX: item_arrow.width/4
            startY: item_arrow.height*3/4
            PathLine { x:item_arrow.width/4; y:item_arrow.height/4 }
            PathLine { x:item_arrow.width/2; y:item_arrow.height/2 }
            PathLine { x:item_arrow.width/4; y:item_arrow.height*3/4 }
        }
    }

    background: Rectangle {
        implicitWidth: 120
        implicitHeight: 30
        x: 1
        y: 1
        width: control.width - 2
        height: control.height - 2
        color: control.menuColor
    }
}

