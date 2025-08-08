import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

// 桌面右下角弹框
// 使用时给content赋值一个Item展示内容，
// 如content: Rectangle{}
// 目前还存在得问题：
// 1.被模态框阻塞无法点击
// 2.鼠标是否hover的判断，会被content的MouseArea遮盖，
// 要么content的MouseArea不设置hoverEnable
// TODO: 消除提示 QSGThreadedRenderLoop: expose event received for window ...
Window {
    id: control
    visible: false
    color: "transparent"
    // 透明度
    opacity: 0
    // 无边框-提示框
    flags: Qt.FramelessWindowHint | Qt.ToolTip
    // 默认非模态
    modality: Qt.NonModal
    // 初始位置，在屏幕右下角
    x: Screen.virtualX + Screen.width - width
    y: Screen.virtualY + Screen.height
    // 大小绑定
    width: content_loader.width
    height: content_loader.height + title_item.height
    // 标题
    property alias title: title_text.text
    // 内容
    property alias content: content_loader.sourceComponent

    MouseArea {
        id: tip_mouse
        anchors.fill: parent
        hoverEnabled: true
    }
    // 标题栏
    Rectangle {
        id: title_item
        height: 30
        width: control.width
        // 标题文字
        Text {
            id: title_text
            anchors{
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 10
            }
        }
        // 关闭按钮-可以用image替换
        Rectangle {
            // 不能绑定text大小，不然会变
            width: 60
            height: 20
            anchors{
                verticalCenter: parent.verticalCenter
                right: parent.right
                rightMargin: 10
            }
            color: close_mouse.containsMouse ? "gray" : "white"
            border.color: "black"
            Text {
                id: close_text
                anchors.centerIn: parent
                // 鼠标放上去显示关闭，否则显示倒计时
                text: (close_mouse.containsMouse || close_timer.time_count < 1)
                      ? qsTr("Close")
                      : close_timer.time_count + " S"
            }
            MouseArea {
                id: close_mouse
                anchors.fill: parent
                hoverEnabled: true
                onClicked: control.hideTip()
            }
            // 关闭倒计时
            Timer {
                id: close_timer
                property int time_count: 0
                interval: 1000
                repeat: true
                onTriggered: {
                    // 倒计时为0，且鼠标不在上面
                    if (time_count < 1 &&
                            !tip_mouse.containsMouse &&
                            !close_mouse.containsMouse) {
                        hideTip()
                    } else {
                        time_count--
                    }
                }
            }
        }
    }
    // 用于加载内容
    Loader {
        id: content_loader
        anchors.top: title_item.bottom
    }

    // 显示-动画组
    ParallelAnimation {
        id: show_anim
        // 透明度-从透明到显示
        NumberAnimation {
            target: control
            property: "opacity"
            // 从当前值到显示
            from: control.opacity
            to: 1
            duration: 2000
        }
        // 位置
        NumberAnimation {
            target: control
            property: "y"
            // 从当前值到显示
            from: control.y
            to: Screen.virtualY + Screen.height - height
            duration: 2000
        }
        // 动画开始，显示窗口
        onStarted: {
            close_timer.time_count = 5
            control.show()
        }
        // 动画结束启动关闭倒计时
        onFinished: {
            close_timer.start()
        }
    }

    // 关闭-动画组
    ParallelAnimation {
        id: hide_anim
        // 透明度-从显示到透明
        NumberAnimation {
            target: control
            property: "opacity"
            // 从当前值到隐藏
            from: control.opacity
            to: 0
            duration: 2000
        }
        // 位置
        NumberAnimation {
            target: control
            property: "y"
            // 从当前值到隐藏
            from: control.y
            to: Screen.virtualY + Screen.height
            duration: 2000
        }
        // 结束动画开始
        onStarted: {
            close_timer.time_count = 0
        }
        // 动画结束关闭窗口
        onFinished: {
            close_timer.stop()
            control.close()
        }
    }

    // 显示弹框
    function showTip()
    {
        hide_anim.stop()
        show_anim.start()
    }
    // 隐藏弹框
    function hideTip()
    {
        show_anim.stop()
        hide_anim.start()
    }
}
