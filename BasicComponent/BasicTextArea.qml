import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T

// Qt5富文本编辑框
// 龚建波 2025-08-07
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\TextArea.qml
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\quicktemplates2\qquicktextarea_p.h
T.TextArea {
    id: control

    // 可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    // 定义主题颜色
    property color themeColor: "darkCyan"
    // 定义文本颜色
    property alias textColor: control.color
    // 定义背景颜色
    property color backgroundColor: "white"
    // 定义边框宽度
    property int borderWidth: control.activeFocus ? 2 : 1
    // 定义边框颜色
    property color borderColor: (activeFocus || hovered) ? themeColor : "black"
    // 定义边框圆角
    property int radius: 0

    // 默认宽高
    // implicitWidth: Math.max(contentWidth + leftPadding + rightPadding,
    //                         implicitBackgroundWidth + leftInset + rightInset,
    //                         placeholder.implicitWidth + leftPadding + rightPadding)
    // implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
    //                          implicitBackgroundHeight + topInset + bottomInset,
    //                          placeholder.implicitHeight + topPadding + bottomPadding)
    implicitWidth: 200
    implicitHeight: 30
    // 边距
    padding: 6
    leftPadding: padding + 2
    rightPadding: padding + 2
    // 字体设置
    font{
        family: "SimSun"
        pixelSize: 16
    }
    // 截取超出部分，TextField文字内容默认是不会超出的
    // clip: true
    // 默认Text.QtRendering看起来比较模糊
    renderType: Text.NativeRendering
    // 只读
    // readOnly: false
    // 文本左对齐
    horizontalAlignment: TextInput.AlignLeft
    // 文本默认顶部对齐
    // verticalAlignment: TextInput.AlignVCenter
    // 文本颜色
    color: "black"
    // 允许鼠标选取文本块
    selectByMouse: true
    // 选中文本的颜色
    selectedTextColor: "white"
    // 选中文本背景色
    selectionColor: "blue"
    // 空文本时提示信息颜色
    placeholderTextColor: Color.transparent(control.color, 0.5)
    // 是否检测hover鼠标悬停，默认会跟随父组件的设置
    hoverEnabled: true
    // 新的输入覆盖光标后面的文本
    // overwriteMode: true
    // 文本换行，默认NoWrap
    // wrapMode: TextInput.Wrap

    // 一些只读属性
    // 一些复制粘贴相关的我略去了
    // 文本高度
    // contentHeight: real
    // 文本宽度
    // contentWidth: real
    // 文本行数
    // lineCount: int
    // 文本字符长度
    // length: int
    // 选中的文本
    // selectedText: string

    // 附加属性
    // flickable: TextArea

    // 信号
    // 当按下Return或Enter键或文本输入失去焦点时
    // onEditingFinished: { console.log("edit onEditingFinished") }
    // 鼠标单击嵌入的链接，链接必须是富文本或HTML格式
    // 链接如: <a href='http://www.baidu.com'>baidu</a>
    // onLinkActivated: (link)=>{ console.log("edit onLinkActivated", link) }
    // 鼠标悬停在嵌入的链接，链接必须是富文本或HTML格式
    // onLinkHovered: (link)=>{ console.log("edit onLinkHovered", link) }
    // 鼠标按下
    // onPressed: { console.log("edit onPressed") }
    // 鼠标弹起释放
    // onReleased: { console.log("edit onReleased") }
    // 鼠标长按
    // onPressAndHold: { console.log("edit onPressAndHold") }

    // 内容为空时的提示信息
    PlaceholderText {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)

        text: control.placeholderText
        font: control.font
        color: control.placeholderTextColor
        verticalAlignment: control.verticalAlignment
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        elide: Text.ElideRight
        renderType: control.renderType
    }

    // 背景
    background: Rectangle {
        implicitWidth: 200
        implicitHeight: 30
        color: control.backgroundColor
        border.width: control.borderWidth
        border.color: control.borderColor
        radius: control.radius
    }
}
