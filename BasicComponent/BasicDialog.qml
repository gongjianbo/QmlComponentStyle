import QtQuick 2.15
import QtQuick.Controls 2.15

// Qt5按钮样式自定义
// 龚建波 2025-03-05
// 参考：qt-everywhere-src-5.15.2\qtquickcontrols2\src\imports\controls\Dialog.qml
// Qt5 Dialog和QWidgets的对话框不一样，不能在Window外显示
// Dialog继承自Popup，增加了header和footer
Dialog {
    id: control

    // 默认宽高，根据内容计算
    // implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
    //                         contentWidth + leftPadding + rightPadding,
    //                         implicitHeaderWidth,
    //                         implicitFooterWidth)
    // implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
    //                          contentHeight + topPadding + bottomPadding
    //                          + (implicitHeaderHeight > 0 ? implicitHeaderHeight + spacing : 0)
    //                          + (implicitFooterHeight > 0 ? implicitFooterHeight + spacing : 0))
    width: 500
    height: 500
    // title: "Dialog"
    // 模态显示，默认false
    modal: true
    // 默认为点击别处就关闭对话框，可以设置closePolicy修改决策
    // closePolicy: Popup.NoAutoClose
    // 可设置居中，默认为parent左上角
    anchors.centerIn: parent
    // Overlay为弹出窗口提供图层，确保弹出窗口显示在其他内容上方
    // 绑定到Window上
    parent: Overlay.overlay
    // 模态显示时，overlay区域默认显示半透明遮罩，这里重新设置了
    Overlay.modal: Rectangle {
        // 默认值Color.transparent(control.palette.shadow, 0.5)
        color: Qt.rgba(0.5, 0.1, 0.1, 0.2)
    }
    // 是否显示modal时的overlay遮罩，默认绑定modal
    // dim: true
    // 当dim=true，模态显示Overlay.modal遮罩，非模态显示Overlay.modeless
    Overlay.modeless: Rectangle {
        // 默认值Color.transparent(control.palette.shadow, 0.12)
        color: Qt.rgba(0.5, 0.1, 0.1, 0.2)
    }
    // 显示隐藏的过渡
    // 这里写个淡入淡出
    // 这里还有个问题就是退场动画还没执行overlay就消失了
    enter: Transition {
        NumberAnimation {
            properties: "opacity"
            duration: 1000
            from: 0
            to: 1
        }
    }
    exit: Transition {
        NumberAnimation{
            properties: "opacity"
            duration: 1000
            from: 1
            to: 0
        }
    }
    // 在没有设置footer的时候，standardButtons枚举可以启用默认的按钮
    // standardButtons: Dialog.Cancel | Dialog.Ok
    // contentItem的边距
    padding: 10
    // 上中下的间距
    spacing: 10

    // 整个对话框的背景
    background: Rectangle {
        color: "white"
        border.color: "gray"
        radius: 10
    }

    // 头部
    header: Rectangle {
        id: header_item
        height: 50
        color: "transparent"
        border.color: "green"
        property int pressX: 0
        property int pressY: 0
        property bool onMoving: false
    }

    // 中心区域
    contentItem: Rectangle {
        border.color: "red"
    }

    // 底部
    footer: Rectangle {
        height: 50
        color: "transparent"
        border.color: "blue"

        // accept()/done() 触发 accepted()信号
        // reject() 触发 rejected() 信号
        // 等等相关信号

        Row {
            anchors.centerIn: parent
            spacing: 10
            Button {
                text: "accept"
                onClicked: control.accept()
            }
            Button {
                text: "done 0"
                onClicked: control.done(0)
            }
            Button {
                text: "close"
                // 直接close，或者visible=false是没有信号的
                onClicked: control.close()
            }
        }
    }

    // Dialog.result属性值对应调用的函数，都可以看做done的wrapper
    onAccepted: console.log("onAccepted", control.result)
    onAboutToHide: console.log("onAboutToHide")
    onAboutToShow: console.log("onAboutToShow")
    onClosed: console.log("onClosed")
    onOpened: console.log("onOpened")
}

