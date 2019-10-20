import QtQuick 2.12
import QtQuick.Templates 2.12 as T

T.TabBar {
    id: control

    property color backgroundColor: "white"
    property color borderColor: "black"

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    spacing: 1

    contentItem: ListView {
        model: control.contentModel
        currentIndex: control.currentIndex

        spacing: control.spacing
        orientation: ListView.Horizontal
        boundsBehavior: Flickable.StopAtBounds
        flickableDirection: Flickable.AutoFlickIfNeeded
        snapMode: ListView.SnapToItem

        highlightMoveDuration: 0
        highlightRangeMode: ListView.ApplyRange
        preferredHighlightBegin: 40
        preferredHighlightEnd: width - 40
    }

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
