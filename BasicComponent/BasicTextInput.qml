import QtQuick 2.15

// Qt5普通编辑框（区别于富文本编辑框）
// 龚建波 2025-07-25
// 参考：qt-everywhere-src-5.15.2\qtdeclarative\src\quick\items\qquicktextinput_p.h
// TextInput 是 TextField 父类，是 QtQuick 基础模块的组件，而 TextField 是 Controls 模块的
TextInput {
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
    // 截取超出部分
    clip: true
    // 默认Text.QtRendering看起来比较模糊
    renderType: Text.NativeRendering
    // 只读
    // readOnly: false
    // 文本左对齐
    horizontalAlignment: TextInput.AlignLeft
    // 文本默认顶部对齐
    verticalAlignment: TextInput.AlignVCenter
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
    // 超出宽度时开启允许滚动，默认为true
    // autoScroll: true
    // 显示模式：Normal普通文本，Password密码，NoEcho无显示，
    // PasswordEchoOnEdit显示在编辑时输入的字符，否则与相同TextInput.Password
    echoMode: TextInput.Normal
    // Password显示的字符，默认是个圆点
    // passwordCharacter: "*"
    // Password由普通字符到被特殊符号替换的间隔
    // passwordMaskDelay: 1000
    // 输入掩码，参照Widgets版本的的QLineEidt::inputMask，类似正则
    // inputMask: ">XXXXX;*"
    // 输入限制，如IntValidator,DoubleValidator,RegExpValidator
    // 设置validator后，内容为空似乎不会触发onAccepted和onEditingFinished了
    // validator: RegExpValidator { regExp: /[0-9]+/ }
    // 文本字符最大允许长度
    // maximumLength: 10
    // 新的输入覆盖光标后面的文本
    // overwriteMode: true
    // 文本换行，默认NoWrap
    wrapMode: TextInput.Wrap

    // 一些只读属性
    // 一些复制粘贴相关的我略去了
    // 文本高度
    // contentHeight: real
    // 文本宽度
    // contentWidth: real
    // 与text属性不同，displayText包含来自输​​入法的部分文本输入
    // displayText: string
    // 文本字符长度
    // length: int
    // 选中的文本
    // selectedText: string

    // 信号
    // 当按下Return或Enter键时，将发出此信号
    // onAccepted: { console.log("edit onAccepted") }
    // 当按下Return或Enter键或文本输入失去焦点时
    // onEditingFinished: { console.log("edit onEditingFinished") }
    // 每当编辑文本时，都会发出此信号
    // 与textChanged不同的是，编程方式修改文本时不触发此信号
    // onTextEdited: { console.log("edit onTextEdited") }
}
