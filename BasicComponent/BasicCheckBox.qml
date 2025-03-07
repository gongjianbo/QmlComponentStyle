import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15

// Qt5勾选框样式自定义
// 龚建波 2025-03-07
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\CheckBox.qml
// CheckBox继承自AbstractButton，增加了checkState/nextCheckState/tristate三个属性
T.CheckBox {
    id:control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    property color themeColor: "darkCyan"
    // 定义文本颜色
    property color textColor: "white"
    // 定义背景颜色
    // 如果不需要背景，可以设置 background: Item {}
    // pressed按下，hovered鼠标悬停，highlighted高亮，checked选中
    property color backgroundColor: control.pressed
                                    ? Qt.darker(themeColor)
                                    : (control.hovered || control.highlighted)
                                      ? Qt.lighter(themeColor)
                                      : control.checked
                                        ? themeColor
                                        : themeColor
    // 定义边框宽度
    property int borderWidth: 0
    // 定义边框颜色
    property color borderColor: Qt.darker(themeColor)
    // 定义边框圆角
    property int radius: 0

    // 默认宽度，参考Qt源码的写法，实际应用可以删减
    // Math.max表示取两者中最大值，1为默认背景宽度+左右偏移值，2为默认内容宽度+左右边距
    // inset和padding都是Control基类定义的，默认为0
    // implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    //                         implicitContentWidth + leftPadding + rightPadding)
    // 默认高度
    // implicitIndicatorHeight为indicator勾选部件的默认高度
    // implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    //                          implicitContentHeight + topPadding + bottomPadding,
    //                          implicitIndicatorHeight + topPadding + bottomPadding)
    // 通过内容计算宽高可能会导致一组按钮的宽高都不齐，可以用固定的默认宽高，或者固定高但是宽度自适应
    implicitWidth: implicitContentWidth + leftPadding + rightPadding
    implicitHeight: implicitIndicatorHeight + topPadding + bottomPadding
    // 边距
    padding: 0
    // 上下边距可以直接用verticalPadding，因为遇到过相关bug就单独设置下
    topPadding: 3
    bottomPadding: 3
    // 左右边距可以直接用horizontalPadding，因为遇到过相关bug就单独设置下
    leftPadding: 8
    rightPadding: 8
    // 图标和文字间距
    spacing: 6
    // 字体设置
    // 也可以给QApplication设置全局的默认字体
    font{
        family: "SimSun"
        pixelSize: 16
    }
    // 勾选图标设置
    // icon.width: 24
    // icon.height: 24
    // 这个图标资源是Control模块默认提供的
    icon.source: "qrc:/qt-project.org/imports/QtQuick/Controls.2/images/check.png"
    icon.color: textColor

    // Control组件点击之后，后续按空格也会触发点击，可以把空格过滤掉
    Keys.onPressed: event.accepted = (event.key === Qt.Key_Space)
    Keys.onReleased: event.accepted = (event.key === Qt.Key_Space)
    // 是否可以选中，设置tristate后似乎禁止勾选失效了
    // checkable: false
    // 是否启用三态模式，选中/半选中/未选中
    // 半选中一般用在树形列表，只选择了子项中的一部分时
    tristate: false
    // 当前的选中状态
    // - Qt.Unchecked 未选中
    // - Qt.PartiallyChecked 半选中
    // - Qt.Checked 选中
    // checkState: Qt.Checked
    // 点击后下一次的状态
    // nextCheckState: function() { return (checkState === Qt.Checked) ? Qt.Unchecked : Qt.Checked }
    // 是否检测hover鼠标悬停，默认会跟随父组件的设置
    hoverEnabled: true
    // 文本内容
    // text: "CheckBox"

    // 按下后移出按钮范围触发取消
    // onCanceled: console.log("canceled")
    // 点击信号
    // onClicked: console.log("clicked")
    // 点击并变更状态后触发toggled，设置tristate后没触发
    // onToggled: console.log("toggled")

    // 勾选图标
    indicator: Rectangle {
        implicitWidth: 24
        implicitHeight: 24
        // 设置勾选图标位置
        x: control.text ? control.leftPadding : control.leftPadding + (control.availableWidth - width) / 2
        y: (parent.height - height) / 2
        // indicator默认层级在background上，这里只是显示勾选部件的边框，所以color设置成透明
        color: "transparent"
        // 图标外面的矩形框
        border.width: 1
        border.color: icon.color
        // 用impl模块的ColorImage，便于设置图标颜色
        ColorImage {
            anchors.centerIn: parent
            // 借用Button已有的icon接口设置图标url
            source: control.icon.source
            // 借用Button已有的icon接口设置图标尺寸
            sourceSize: Qt.size(control.icon.width, control.icon.height)
            // 借用Button已有的icon接口设置图标颜色
            color: control.icon.color
            // 勾选状态下显示勾选图标
            visible: control.checkState === Qt.Checked
        }
        // 部分选中（Qt.PartiallyChecked）时不显示勾，显示一个实心方形
        // 设置CheckBox的tristate为true后才支持三态
        Rectangle {
            anchors.centerIn: parent
            width: parent.width / 2
            height: parent.height / 2
            color: icon.color
            // 半选状态下显示实心方形
            visible: control.checkState === Qt.PartiallyChecked
        }
    }

    // 文本描述
    // 源码中用的CheckLabel继承自Text，只是默认设置了AlignLeft+AlignVCenter+ElideRight
    contentItem: Text {
        // 文字内容
        text: control.text
        // 字体设置
        font: control.font
        // 颜色设置
        color: control.textColor
        // 文字对齐方式
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        // 单独设置文本组件的渲染方式
        renderType: Text.NativeRendering
        // 文字超出按钮范围显示省略号
        elide: Text.ElideRight
        // contentItem宽度是包含了indicator的，通过padding把位置留出来
        leftPadding: control.indicator.width + control.spacing
        rightPadding: 0
    }

    // 背景
    background: Rectangle {
        // control设置了背景无关的宽高，这里也可以不设置默认宽高
        implicitWidth: control.implicitWidth
        implicitHeight: control.implicitHeight
        // 背景圆角
        radius: control.radius
        // 背景颜色
        color: control.backgroundColor
        // 背景边框
        border.width: control.borderWidth
        border.color: control.borderColor
    }
}
