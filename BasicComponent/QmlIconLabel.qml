import QtQuick 2.15

// QtQuick.control2带Icon的Label是个单独的控件：IconLabel
// 但是自定义起来不大方便，比如没有renderType那就只能全局设置该属性
// 而IconLabel源码中用的也比较多，我就单独组合一个
// Item可以替换为Rectangle以设置背景色
Item {
    id: control

    property alias source: _icon.source
    property alias text: _text.text
    property alias color: _text.color
    property alias font: _text.font
    property alias spacing: _row.spacing
    // 懒得写，直接全部引出
    property alias controlImage: _icon
    property alias controlText: _text
    property alias controlRow: _row

    implicitWidth: ((_icon.source && _text.implicitWidth) ? _row.spacing : 0)
                   + _icon.implicitWidth + _text.implicitWidth
                   + _row.leftPadding + _row.rightPadding
    implicitHeight: 30
    Row {
        id: _row
        // 图标和文本居中并排的话可以anchors.centerIn: parent
        height: parent.height
        width: parent.width
        spacing: 6
        padding: 0
        // leftPadding: 6
        // rightPadding: 6

        Image {
            id: _icon
            anchors{
                verticalCenter: parent.verticalCenter
            }
        }
        Text {
            id: _text
            // 如果组件宽度固定，那文字区域宽度也是固定的，这样图标的位置也是固定的
            // 就不会因为文字长短不齐导致图标位置不固定了
            width: control.width - _icon.width - _row.leftPadding - _row.rightPadding
            anchors{
                verticalCenter: parent.verticalCenter
            }
            color: "black"
            renderType: Text.NativeRendering
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            // wrapMode: Text.NoWrap
            elide: Text.ElideRight
            font{
                family: "SimSun"
                pixelSize: 16
            }
        }
    }
}
