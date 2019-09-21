import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls.impl 2.12

//qtquickcontrols2\src\imports\controls\BusyIndicator.qml
//from Customizing BusyIndicator
T.BusyIndicator {
    id: control

    property color themeColor: "darkCyan"
    property int opacityDuration: 250

    implicitWidth: 64
    implicitHeight: 64
    padding: 6

    contentItem: BusyIndicatorImpl {
        implicitWidth: 64
        implicitHeight: 64

        pen: Qt.lighter(themeColor)
        fill: themeColor

        running: control.running
        opacity: control.running ? 1 : 0
        Behavior on opacity {
            OpacityAnimator { duration: opacityDuration }
        }
    }
}
