import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15

// Qt5下拉框样式自定义
// 龚建波 2025-03-10
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\ComboBox.qml
T.ComboBox {
    id: control

    // 定义主题颜色
    property color themeColor: "darkCyan"
    // 定义文本颜色
    property color textColor: "white"
    // 定义背景渐变色
    property Gradient backgroundGradient: (control.pressed || control.checked)
                                          ? _pressGradient
                                          : (control.hovered || control.highlighted)
                                            ? _hoverGradient
                                            : _normalGradient
    property Gradient _pressGradient: Gradient {
        GradientStop { position: 0.0; color: Qt.darker(themeColor) }
        GradientStop { position: 0.5; color: themeColor }
        GradientStop { position: 1.0; color: Qt.lighter(themeColor) }
    }
    property Gradient _hoverGradient: Gradient {
        GradientStop { position: 0.0; color: themeColor }
        GradientStop { position: 0.5; color: Qt.darker(themeColor) }
        GradientStop { position: 1.0; color: themeColor }
    }
    property Gradient _normalGradient: Gradient {
        GradientStop { position: 0.0; color: Qt.lighter(themeColor) }
        GradientStop { position: 0.5; color: themeColor }
        GradientStop { position: 1.0; color: Qt.lighter(themeColor) }
    }
    property Gradient _lightToNormal: Gradient {
        GradientStop { position: 0.0; color: Qt.lighter(themeColor) }
        GradientStop { position: 0.6; color: themeColor }
    }
    property Gradient _normalToDark: Gradient {
        GradientStop { position: 0.2; color: themeColor }
        GradientStop { position: 0.9; color: Qt.darker(themeColor) }
    }
    // 定义边框圆角
    property int radius: 4
    // 定义每个item的高度
    property int itemHeight: height
    // 定义文本的左右padding
    property int itemPadding: 10
    // 定义下拉选项高亮颜色
    property color itemHighlightColor: Qt.darker(themeColor)
    // 定义下拉选项默认颜色
    property color itemNormalColor: themeColor
    // 定义下拉图标宽度，小于0就用图标宽度
    property int indicatorWidth: -1
    // 定义下拉按钮左右边距，不然rightPadding和indicator宽度循环引用计算
    property int indicatorPadding: 3
    // 定义下拉按钮图标
    property url indicatorSource: "qrc:/qt-project.org/imports/QtQuick/Controls.2/images/double-arrow.png"
    // 定义下拉图标颜色
    property color indicatorColor: textColor
    // 定义下拉列表展示选项个数，多余的需要滚动
    property int showCount: 5
    // 定义文本显示的回调
    // 如文字左右加[]，{ return String('[%1]').arg(value); }
    // 如根据编码显示对应文字，{ return switch(value) { case:... }; }
    // 不能用在编辑的场景
    property var showFunc: function(value){
        return value;
    }

    // 默认固定宽高
    implicitWidth: 120
    implicitHeight: 30
    // 边距
    padding: 0
    // 左右边距可以直接用horizontalPadding，因为遇到过相关bug就单独设置下
    leftPadding: 0
    // 右边距需要把按钮位置留出来
    rightPadding: indicator.width
    // 图标和文字间距，用indicatorPadding计算，这里为0
    spacing: 0
    // 字体设置
    // 也可以给QApplication设置全局的默认字体
    font{
        family: "SimSun"
        pixelSize: 16
    }
    // 是否检测hover鼠标悬停，默认会跟随父组件的设置
    hoverEnabled: true

    // 下拉选项样式
    delegate: ItemDelegate {
        // 选项宽高
        width: ListView.view.width
        height: control.itemHeight
        // 选项边距
        padding: control.padding
        leftPadding: control.itemPadding
        rightPadding: control.itemPadding
        contentItem: Text {
            // 选项文字内容
            text: control.showFunc(control.textRole
                                   ? (Array.isArray(control.model)
                                      ? modelData[control.textRole]
                                      : model[control.textRole])
                                   : modelData)
            // 字体设置
            font: control.font
            // 颜色设置
            color: control.textColor
            // 文字对齐方式
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            // 单独设置文本组件的渲染方式
            renderType: Text.NativeRendering
            // 文字超出按钮范围显示省略号
            elide: Text.ElideRight
        }
        // 是否检测hover鼠标悬停
        hoverEnabled: control.hoverEnabled
        // 选项背景
        background: Rectangle {
            gradient: (control.highlightedIndex === index)
                      ? _normalToDark
                      : _lightToNormal
        }
    }

    // 下拉按钮图标
    indicator: Item {
        id: box_indicator
        // 下拉图标定位
        x: control.width - width
        y: control.topPadding + (control.availableHeight - height) / 2
        // 下拉按钮区域占的尺寸
        width: (indicatorWidth < 0 ? box_indicator_img.width : indicatorWidth) + control.indicatorPadding * 2
        height: control.height
        // 下拉按钮图标
        ColorImage {
            id: box_indicator_img
            anchors.centerIn: parent
            // 图标颜色
            color: control.indicatorColor
            // 图标url
            source: control.indicatorSource
        }
    }

    // 当前展示内容项，可以单独封装然后组合在这里
    // 如果不需要支持编辑，用Text或者Label也行
    contentItem: T.TextField {
        id: content_edit
        // 左右边距
        leftPadding: control.itemPadding
        rightPadding: control.itemPadding
        // 文字内容
        text: control.editable
              ? control.editText
              : control.showFunc(control.displayText)
        // 字体设置
        font: control.font
        // 文字颜色
        color: control.textColor
        // 默认鼠标选取文本设置为false
        selectByMouse: true
        // 选中文本的颜色
        selectedTextColor: "white"
        // 选中文本背景色
        selectionColor: "black"
        // 超出区域后截断不显示
        clip: true
        // 单独设置文本组件的渲染方式
        renderType: Text.NativeRendering
        // 文字对齐方式
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        // 设置为可编辑时，才允许编辑
        enabled: control.editable
        // 设置为可编辑时，填充的文本自动滚动到末尾
        autoScroll: control.editable
        // 下拉时只读
        readOnly: control.down
        // 对输入内容限制，如字符隐藏/只允许输入数字等
        // 区别于echoMode，如密码非明文显示 echoMode: TextInput.Password
        inputMethodHints: control.inputMethodHints
        // 输入的正则限制
        validator: control.validator
        // 编辑框背景
        background: Rectangle {
            // 可编辑时才显示
            visible: control.enabled && control.editable
            color: content_edit.activeFocus
                   ? Qt.rgba(0.6, 0.6, 0.6, 0.6)
                   : "transparent"
        }
    }

    // 背景
    background: Rectangle {
        // control设置了背景无关的宽高，这里也可以不设置默认宽高
        implicitWidth: control.implicitWidth
        implicitHeight: control.implicitHeight
        // 背景圆角
        radius: control.radius
        // 背景渐变
        gradient: control.backgroundGradient
    }

    // 弹出框
    popup: T.Popup {
        // 默认向下弹出，如果距离不够，y会自动调整（Popup的特性，会被限制在Window内）
        y: control.height
        width: control.width
        // 根据定义的showCount来设置最多显示item个数
        implicitHeight: control.delegateModel
                        ? (control.delegateModel.count < showCount
                           ? contentItem.implicitHeight
                           : control.showCount * control.itemHeight) + 2
                        : 0
        // 留给边框的位置
        padding: 1
        contentItem: ListView {
            implicitHeight: contentHeight
            // 超出区域后截断不显示
            clip: true
            // 列表内容
            model: control.popup.visible ? control.delegateModel : null
            // 选中项同步
            currentIndex: control.highlightedIndex
            // 滚动效果
            // - NoSnap 默认任意位置停止NoSnap
            // - SnapToItem 滑动结束时顶部对齐（不会只漏半截），滑到末尾才是底部对齐
            // - SnapOneItem 滑动结束时最多移动一项
            // SnapToItem可能会导致原地来回跳无法滚动，SnapOneItem不适合做滚动
            // snapMode: ListView.NoSnap
            // 高亮移动动画时间，源码设置为0
            highlightMoveDuration: 0
            // ScrollBar.horizontal: ScrollBar { visible: false }
            // 竖向滚动条，可以单独封装然后组合在这里
            ScrollBar.vertical: ScrollBar {
                id: box_bar
                // 滚动条宽度
                implicitWidth: 10
                visible: (control.delegateModel && control.delegateModel.count > showCount)
                // 滚动条整体背景
                // background: Rectangle { }
                // 拖动的滑动条样式
                contentItem: Rectangle {
                    implicitWidth: 10
                    radius: width / 2
                    color: box_bar.pressed
                           ? Qt.rgba(0.6, 0.6, 0.6)
                           : Qt.rgba(0.6, 0.6, 0.6, 0.5)
                }
            }
        }

        // 弹出框背景（只有popup.padding显示出来了，其余部分被delegate背景遮挡）
        background: Rectangle {
            color: themeColor
            // color: Qt.lighter(themeColor)
            radius: control.radius
        }
    }
}
