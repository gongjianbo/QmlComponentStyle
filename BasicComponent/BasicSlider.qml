import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Templates 2.15 as T

// Qt5滑块
// 龚建波 2025-05-13
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\Slider.qml
T.Slider {
    id: control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    property color themeColor: "darkCyan"
    // 本来想在原来的基础上增加个opposite direction相反方向的属性
    // 奈何handle是和鼠标判定区域挂钩的，所以要做这个的话就不能用原来的handle
    // 相当于自己重新组合一个slider控件
    // 定义滑块按钮颜色
    property color handleColor: control.pressed
                                ? Qt.darker(themeColor)
                                : control.hovered
                                  ? Qt.darker(themeColor, 1.15)
                                  : themeColor
    // 定义滑块按钮边框颜色
    property color handleBorderColor: handleColor
    // 定义已完成部分背景颜色
    property color completeColor: Qt.darker(themeColor, 1.3)
    // 定义未完成部分背景颜色
    property color incompleteColor: Qt.lighter(themeColor)
    // 支持滚轮滑动
    property bool acceptWheel: true

    // 默认宽度，参考Qt源码的写法，实际应用可以删减
    // Math.max表示取两者中最大值，1为默认背景宽度+左右偏移值，2为默认内容宽度+左右边距
    // inset和padding都是Control基类定义的，默认为0
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitHandleHeight + topPadding + bottomPadding)
    // 边距
    padding: 6
    // 起始值，默认0
    // from: 0
    // 终止值，默认1
    // to: 1
    // 当前值，默认0
    // value: 0
    // 步进值，默认0
    // stepSize: 0
    // 方向，横向或竖向，默认横向horizontal
    // orientation: Qt.Horizontal
    // 是否为横向-只读：horizontal
    // 是否为竖向-只读：vertical
    // handle的逻辑位置-只读：position，归一化到[0, 1]
    // handle的视觉位置-只读：visualPosition，归一化到[0, 1]
    // 滑块对齐模式
    // Slider.NoSnap 默认不对齐
    // Slider.SnapAlways 拖动手柄时，滑块会对齐合法值，如设置了stepSize那就根据步进值对齐
    // Slider.SnapOnRelease 滑块在拖动时不会对齐，而仅在释放手柄后对齐
    // snapMode: Slider.NoSnap
    // 启动触摸拖动事件的阈值 （以逻辑像素为单位），鼠标拖动阈值不会受到影响
    // touchDragThreshold: Qt.styleHints.startDragDistance
    // 在拖动手柄时滑块是否为value属性提供实时更新，默认true
    // live: true

    // 拖动滑块后触发，直接修改value或者调用增减函数不会触发
    // onMoved: { console.log("onMoved", value) }
    // 根据步进值减少，未设置步进值则为0.1
    // decrease()
    // 根据步进值增加，未设置步进值则为0.1
    // increase()
    // 根据位置换算对应的值
    // real valueAt(real position)

    // 滑块按钮
    handle: Rectangle {
        x: control.leftPadding + (control.horizontal ? control.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.visualPosition * (control.availableHeight - height))
        // 一个长方体的滑块
        implicitWidth: control.horizontal ? 12 : 20
        implicitHeight: control.horizontal ? 20 : 12
        color: handleColor
        border.width: 1
        border.color: handleBorderColor
    }

    // 背景作为滑动槽
    background: Rectangle {
        // 以control.horizontal为例：
        // control.availableHeight为去掉padding的高度
        // 所以如果control很高的话，只根据padding来算y可能就贴着上面
        // 这时候就需要加一部分(control.availableHeight - height) / 2来对齐
        x: control.leftPadding + (control.horizontal ? 0 : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : 0)
        implicitWidth: control.horizontal ? 200 : 6
        implicitHeight: control.horizontal ? 6 : 200
        width: control.horizontal ? control.availableWidth : implicitWidth
        height: control.horizontal ? implicitHeight : control.availableHeight
        radius: control.horizontal ? height / 2 : width / 2
        color: control.incompleteColor
        // 通过scale=-1来翻转
        scale: control.horizontal && control.mirrored ? -1 : 1

        // 表示已经完成的部分，叠加到上层
        Rectangle {
            y: control.horizontal ? 0 : control.visualPosition * parent.height
            width: control.horizontal ? control.position * parent.width : parent.width
            height: control.horizontal ? parent.height : control.position * parent.height
            radius: control.horizontal ? parent.height / 2 : parent.width / 2
            color: control.completeColor
        }
    }

    // 添加鼠标滚轮滑动支持
    MouseArea {
        visible: acceptWheel
        anchors.fill: parent
        // 不接收点击事件避免和handle冲突
        acceptedButtons: Qt.NoButton
        // 不接收hover事件
        hoverEnabled: false
        onWheel: {
            if (wheel.angleDelta.y < 0) {
                // 根据步进值减少
                control.decrease()
            } else {
                // 根据步进值增加
                control.increase()
            }
        }
    }
}
