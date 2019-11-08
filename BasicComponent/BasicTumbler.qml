import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12
import QtQuick.Templates 2.12 as T

T.Tumbler {
    id: control

    property color normalTextColor: "white"
    property color selectedTextColor: "cyan"
    property color backgroundColor: "darkCyan"
    property Gradient backgroundGradient

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding) || 60 // ### remove 60 in Qt 6
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding) || 200 // ### remove 200 in Qt 6

    font{
        family: "SimSun"
        pixelSize: 16
    }
    delegate: Text {
        text: modelData
        //displacement附加属性包含一个从-visibleItemCount/2到visibleItemCount/2的值，
        //该值表示此项与当前项之间的距离，0表示完全是当前项。
        color: (Tumbler.displacement === 0)
               ?control.selectedTextColor
               :control.normalTextColor
        font: control.font
        opacity: 1.0 - Math.abs(Tumbler.displacement) / (control.visibleItemCount / 2)
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        renderType: Text.NativeRendering
    }

    //TumblerView中有PathView和ListView，通过wrap状态来切换
    //Tumbler wrap为true则使用PathView
    //所以可以自己通过这两个view来实现，参照Customizing Tumbler
    contentItem: TumblerView {
        implicitWidth: 60
        implicitHeight: 200
        model: control.model
        delegate: control.delegate
        path: Path {
            startX: contentItem.width / 2
            startY: -contentItem.delegateHeight / 2
            PathLine {
                x: contentItem.width / 2
                y: (control.visibleItemCount + 1) * contentItem.delegateHeight - contentItem.delegateHeight / 2
            }
        }
        property real delegateHeight: control.availableHeight / control.visibleItemCount
    }
    background: Rectangle{
        color: control.backgroundColor
        gradient: control.backgroundGradient
    }

    Rectangle {
        anchors.horizontalCenter: control.horizontalCenter
        y: control.height * (0.5+0.5/control.visibleItemCount)
        width: control.width*0.8
        height: 1
        color: selectedTextColor
    }

    Rectangle {
        anchors.horizontalCenter: control.horizontalCenter
        y: control.height * (0.5-0.5/control.visibleItemCount)
        width: control.width*0.8
        height: 1
        color: selectedTextColor
    }
}
