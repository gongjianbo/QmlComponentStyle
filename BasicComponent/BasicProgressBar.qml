import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12

//qtquickcontrols2\src\imports\controls\ProgressBar.qml
//from Customizing ProgressBar
T.ProgressBar {
    id: control

    property color themeColor: "darkCyan"

    implicitWidth: 200
    implicitHeight: 10
    //clip: true

    //进度条，可惜不能设置圆角
    contentItem: ProgressBarImpl {
        implicitWidth: 120
        implicitHeight: 10
        scale: control.mirrored ? -1 : 1
        progress: control.position
        //indeterminate表示没有具体值
        indeterminate: control.visible && control.indeterminate
        color: themeColor
    }

    //背景框
    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 10
        y: (control.height - height) / 2
        height: 10
        //radius: height/2
        border.width: 1
        border.color: Qt.lighter(themeColor)
    }
}
