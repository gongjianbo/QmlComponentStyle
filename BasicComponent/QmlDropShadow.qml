import QtQuick 2.15
import QtGraphicalEffects 1.15

// 外阴影矩形
// 龚建波 2025-07-25
Rectangle {
    id: control

    // 右+下偏移
    property int shadowOffset: 2
    // 值越大越浅和远
    property int shadowRadius: 8
    // 阴影颜色
    property color shadowColor: "#33333333"

    radius: 0
    layer.enabled: true
    layer.effect: DropShadow {
        transparentBorder: true
        horizontalOffset: control.shadowOffset
        verticalOffset: control.shadowOffset
        radius: control.shadowRadius
        samples: 16
        color: control.shadowColor
    }
}
