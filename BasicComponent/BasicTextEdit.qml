import QtQuick 2.15

// Qt5富文本编辑框
// 龚建波 2025-08-7
// 参考：qt-everywhere-src-5.15.2\qtdeclarative\src\quick\items\qquicktextedit_p.h
// TextEdit 是 TextArea 父类，是 QtQuick 基础模块的组件，而 TextArea 是 Controls 模块的
// 虽然 TextEdit 支持富文本，但是又没有 maximumLength/validator 等属性，纯文本还是用 TextInput/Field 好点
TextEdit {
    id: control

    // 因为没有background等属性，需要嵌套在Rectangle等组件内
    // 默认宽高
    width: 200
    height: 30
    // 边距
    padding: 6
    leftPadding: padding + 2
    rightPadding: padding + 2
    // 文本颜色
    color: "black"
    // 字体设置
    font{
        family: "SimSun"
        pixelSize: 16
    }
    // 截取超出部分，似乎设置了还是会超出一点，可以在外部套一层来clip
    // clip: true
    // 默认Text.QtRendering看起来比较模糊
    renderType: Text.NativeRendering
    // 只读
    // readOnly: true
    // 文本左对齐
    horizontalAlignment: TextEdit.AlignLeft
    // 文本默认顶部对齐
    // verticalAlignment: TextEdit.AlignVCenter
    // 光标样式自定义
    // cursorDelegate: Rectangle {
    //     width: 2
    //     color: "blue"
    //     property bool cursorRuning: control.cursorVisible
    //     visible: false
    //     SequentialAnimation on visible {
    //         id: cursorAnimation
    //         running: false
    //         loops: Animation.Infinite
    //         PropertyAnimation { from: true; to: false; duration: 750 }
    //         PropertyAnimation { from: false; to: true; duration: 500 }
    //     }
    //     onCursorRuningChanged: {
    //         cursorAnimation.running = cursorRuning
    //         visible = cursorRuning
    //     }
    // }
    // cursorVisible: focus
    // 允许鼠标选取文本块
    selectByMouse: true
    // 选中文本的颜色
    selectedTextColor: "white"
    // 选中文本背景色
    selectionColor: "blue"
    // 新的输入覆盖光标后面的文本
    // overwriteMode: true
    // 文本换行，默认NoWrap
    // wrapMode: TextInput.Wrap
    // 内容格式，可以指定纯文本或富文本
    // 默认TextEdit.PlainText纯文本
    // 还可以设置AutoText/RichText/MarkdownText
    // textFormat: TextEdit.AutoText

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

    // 信号
    // 当按下Return或Enter键或文本输入失去焦点时
    // onEditingFinished: { console.log("edit onEditingFinished") }
    // 鼠标单击嵌入的链接，链接必须是富文本或HTML格式
    // 链接如: <a href='http://www.baidu.com'>baidu</a>
    // onLinkActivated: (link)=>{ console.log("edit onLinkActivated", link) }
    // 鼠标悬停在嵌入的链接，链接必须是富文本或HTML格式
    // onLinkHovered: (link)=>{ console.log("edit onLinkHovered", link) }
}
