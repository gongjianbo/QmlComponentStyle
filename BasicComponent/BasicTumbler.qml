import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T

// Qt5滑动选择框
// 龚建波 2025-04-15
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\Tumbler.qml
T.Tumbler {
    id: control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    property color themeColor: "darkCyan"
    // 非选中时文本颜色
    property color normalTextColor: "white"
    // 选中时文本颜色
    property color selectedTextColor: "cyan"
    // 背景色
    property color backgroundColor: themeColor
    // 背景可设置渐变
    property Gradient backgroundGradient

    // 默认宽度，参考Qt源码的写法，实际应用可以删减
    // Math.max表示取两者中最大值，1为默认背景宽度+左右偏移值，2为默认内容宽度+左右边距
    // inset和padding都是Control基类定义的，默认为0
    // implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    //                         implicitContentWidth + leftPadding + rightPadding)
    // 默认高度
    // implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    //                          implicitContentHeight + topPadding + bottomPadding)
    implicitWidth: implicitContentWidth + leftPadding + rightPadding
    implicitHeight: implicitBackgroundHeight + topPadding + bottomPadding
    // 边距
    padding: 6
    // 字体设置
    // 也可以给QApplication设置全局的默认字体
    font{
        family: "SimSun"
        pixelSize: 16
    }

    // 数据源model
    // 元素个数count
    // 是否在移动moving
    // 当前选中索引currentIndex
    // 可见元素个数
    // visibleItemCount: 10
    // 是环绕滚动还是ListView上下滚动
    // wrap: false

    // 附加属性
    // Tumbler.displacement包含一个从-visibleItemCount/2到visibleItemCount/2的值，
    // 该值表示此项与当前项之间的距离，0表示完全是当前项。
    // Tumbler.tumbler类似于ListView.view，获取组件引用

    // 成员函数
    // positionViewAtIndex(int index, PositionMode mode)
    // 定位视图到指定位置

    // 选项样式
    delegate: Text {
        text: modelData
        color: (model.index === control.currentIndex)
               ? control.selectedTextColor
               : control.normalTextColor
        opacity: 1.0 - Math.abs(Tumbler.displacement) / (control.visibleItemCount / 2)
        font: control.font
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        renderType: Text.NativeRendering
    }

    // TumblerView中有PathView和ListView，通过wrap属性来切换，
    // Tumbler wrap为true则使用PathView，但是没导出内部view引用来对细节设置
    // 所以可以自己通过这两个view来实现，参照Customizing Tumbler
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

    // 背景色
    background: Rectangle {
        color: control.backgroundColor
        gradient: control.backgroundGradient
    }

    // 当前项上下加一条横线样式
    Rectangle {
        anchors.horizontalCenter: control.horizontalCenter
        y: control.height * (0.5 + 0.5 / control.visibleItemCount)
        width: control.width * 0.8
        height: 1
        color: selectedTextColor
    }
    Rectangle {
        anchors.horizontalCenter: control.horizontalCenter
        y: control.height * (0.5 - 0.5 / control.visibleItemCount)
        width: control.width * 0.8
        height: 1
        color: selectedTextColor
    }
}
