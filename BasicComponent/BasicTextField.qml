import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T

// Qt5普通编辑框（区别于富文本编辑框）
// 龚建波 2025-07-28
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\TextField.qml
T.TextField {
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

    // implicitWidth: implicitBackgroundWidth + leftInset + rightInset
    //                || Math.max(contentWidth, placeholder.implicitWidth) + leftPadding + rightPadding
    // implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    //                          contentHeight + topPadding + bottomPadding,
    //                          placeholder.implicitHeight + topPadding + bottomPadding)

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
    verticalAlignment: TextInput.AlignVCenter
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
