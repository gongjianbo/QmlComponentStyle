import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Templates 2.15 as T

// Qt5标签样式自定义
// 龚建波 2025-04-23
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\Label.qml
// Label继承自Text，只是增加了padding/inset/background等没啥用的属性
T.Label {
    id: control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    property color themeColor: "darkCyan"

    // 文本颜色
    color: mouse_area.containsMouse ? Qt.lighter(themeColor) : "black"
    // 边距
    padding: 3
    // 字体设置
    // 也可以给QApplication设置全局的默认字体
    font{
        family: "SimSun"
        pixelSize: 16
    }
    // 单独设置文本组件的渲染方式
    renderType: Text.NativeRendering
    // 文字对齐方式，设置Text宽高后设置才有意义
    verticalAlignment: Text.AlignVCenter
    horizontalAlignment: Text.AlignHCenter
    // 宽度不够时显示省略号
    elide: Text.ElideRight
    // html href链接颜色
    linkColor: mouse_area.containsMouse ? Qt.lighter(themeColor) : themeColor

    // 获取鼠标hover状态
    MouseArea {
        id: mouse_area
        anchors.fill: parent
        hoverEnabled: true
        acceptedButtons: Qt.NoButton
    }
}
