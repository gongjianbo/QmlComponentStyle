import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12

T.MenuBar {
    id: control

    property color backgroundColor: "white"
    property color borderColor: "black"

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    font{
        family: "SimSun"
        pixelSize: 16
    }
    delegate: BasicMenuBarItem { }

    contentItem: Row {
        spacing: control.spacing
        Repeater {
            model: control.contentModel
        }
    }

    //背景在MenuBarItem之下，所以自定义底框可以用单独的横条和MenuBar组合
    background: Rectangle {
        implicitHeight: 30
        color: control.backgroundColor

        Rectangle {
            color: control.borderColor
            width: parent.width
            height: 1
            anchors.bottom: parent.bottom
        }
    }
}
