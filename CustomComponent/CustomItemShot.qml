import QtQuick 2.15
import QtQuick.Dialogs 1.2

// 框选截图工具
// 使用时需要anchors.fill目标，并把目标赋值给shotTarget
// pop()初始化显示，close()隐藏
// 注意要放在target Item的外部，不然截图组件的影像也被捕获了

// 2019-12-21
// 设置preventStealing: true防止鼠标事件被偷走
// 如在ScrollView或Map中，MouseArea不能正常处理拖动效果
Item {
    id: control
    visible: false

    property int areaMinSize: 35
    property int indicatorWidth: 14
    property color indicatorColor: "red"
    property alias areaBorder: shot_area.border
    property alias areaColo: shot_area.color
    property alias centerText: center_text.text
    property alias textColor: center_text.color
    property alias textFont: center_text.font
    // 要截图的Item，通过ShaderEffectSource来获取目标区域
    property alias shotTarget: shot_shader.sourceItem

    // 尺寸改变时，避免超出范围
    onWidthChanged: {
        if (shot_area.x + shot_area.width > control.width) {
            shot_area.width = control.width - shot_area.x
        }
    }
    onHeightChanged: {
        if (shot_area.y + shot_area.height > control.height) {
            shot_area.height = control.height - shot_area.y
        }
    }

    function pop() {
        shot_area.x = 0
        shot_area.y = 0
        shot_area.width = control.width
        shot_area.height = control.height
        control.visible = true
    }

    function close() {
        control.visible = false
    }

    function requestshot() {
        shot_dailog.open()
    }

    function quickitemshot(filepath) {
        shot_shader.sourceRect = Qt.rect(shot_area.x
                                         , shot_area.y
                                         , shot_area.width
                                         , shot_area.height)
        if (shotTarget && filepath) {
            shot_shader.grabToImage(function(result) {
                var saveresult = result.saveToFile(filepath)
                console.log("quickitemshot", saveresult, filepath)
            })
        }
    }

    FileDialog {
        id: shot_dailog
        visible: false
        title: "保存截图"

        // folder: shortcuts.home
        nameFilters: ["Image(*.png)"]
        // 另存文件名
        selectExisting: false
        // 确认
        onAccepted: {
            var selectpath = shot_dailog.fileUrl.toString()
            if (selectpath) {
                // 去掉url中的"file:///"
                control.quickitemshot(selectpath.replace(/^(file:\/{3})/, ""))
            }
        }
        // 取消
        // onRejected:
        // 如果不设置文件路径，那么就要App设置("organizationName", "organizationDomain")
        settings.fileName: "dialog.ini"
    }

    // 用于截图
    ShaderEffectSource {
        id: shot_shader
        visible: false
        anchors.fill: shot_area
        // 数据源
        // sourceItem:
        // 截图区域
        // sourceRect: shot_area.layer.sourceRect
    }

    //截屏区域
    //这里没有处理和窗口等比缩放
    Rectangle {
        id: shot_area
        implicitWidth: control.width
        implicitHeight: control.height

        color: Qt.rgba(0, 1, 0, 0.3)
        border{
            width: 1
            color: "red"
        }

        Text {
            id: center_text
            anchors.centerIn: parent
            text: "双击保存截图"
            color: "red"
            font{
                pixelSize: 16
                weight: Font.Bold
            }
        }

        MouseArea {
            id: click_area
            anchors.fill: parent
            property int pressPointX: 0
            property int pressPointY: 0
            preventStealing: true
            onPressed: {
                pressPointX = mouse.x
                pressPointY = mouse.y
            }

            onDoubleClicked: control.requestshot()
            onPositionChanged: {
                // 判断范围，贴边移动的情况需要细化处理
                if ((shot_area.x + mouse.x - pressPointX > 0)
                        && (shot_area.x + shot_area.width + mouse.x - pressPointX <= control.width)) {
                    shot_area.x += mouse.x - pressPointX
                }
                if ((shot_area.y + mouse.y - pressPointY > 0)
                        && (shot_area.y + shot_area.height + mouse.y - pressPointY <= control.height)){
                    shot_area.y += mouse.y - pressPointY
                }
            }
        }

        // 四角的四个拖动按钮
        Rectangle {
            id: btn_top_left
            width: control.indicatorWidth
            height: control.indicatorWidth
            radius: control.indicatorWidth / 2
            color: control.indicatorColor
            anchors{
                left: parent.left
                top: parent.top
                margins: -radius
            }
            MouseArea {
                property int pressPosX: 0
                property int pressPosY: 0
                anchors.fill: parent
                preventStealing: true
                onClicked: {
                    pressPosX = mouse.x
                    pressPosY = mouse.y
                }
                onPositionChanged: {
                    var new_width = shot_area.width - mouse.x - pressPosX
                    var new_height = shot_area.height - mouse.y - pressPosY
                    if (new_width >= control.areaMinSize) {
                        shot_area.width = new_width
                        shot_area.x += mouse.x - pressPosX
                        if (shot_area.x < 0) {
                            shot_area.width += shot_area.x
                            shot_area.x = 0
                        }
                    }
                    if (new_height >= control.areaMinSize) {
                        shot_area.height = new_height
                        shot_area.y += mouse.y - pressPosY
                        if (shot_area.y < 0) {
                            shot_area.height += shot_area.y
                            shot_area.y = 0
                        }
                    }
                }
            }
        }
        Rectangle {
            id: btn_top_right
            width: control.indicatorWidth
            height: control.indicatorWidth
            radius: control.indicatorWidth / 2
            color: control.indicatorColor
            anchors{
                right: parent.right
                top: parent.top
                margins: -radius
            }
            MouseArea {
                property int pressPosX: 0
                property int pressPosY: 0
                anchors.fill: parent
                preventStealing: true
                onClicked: {
                    pressPosX = mouse.x
                    pressPosY = mouse.y
                }
                onPositionChanged: {
                    var new_width = shot_area.width + mouse.x - pressPosX
                    var new_height = shot_area.height - mouse.y - pressPosY
                    if (new_width >= control.areaMinSize) {
                        shot_area.width = new_width
                        if (shot_area.x + shot_area.width > control.width) {
                            shot_area.width = control.width - shot_area.x
                        }
                    }
                    if (new_height >= control.areaMinSize) {
                        shot_area.height = new_height
                        shot_area.y += mouse.y - pressPosY
                        if (shot_area.y < 0) {
                            shot_area.height += shot_area.y
                            shot_area.y = 0
                        }
                    }
                }
            }
        }
        Rectangle {
            id: btn_bottom_left
            width: control.indicatorWidth
            height: control.indicatorWidth
            radius: control.indicatorWidth / 2
            color: control.indicatorColor
            anchors{
                left: parent.left
                bottom: parent.bottom
                margins: -radius
            }
            MouseArea {
                property int pressPosX: 0
                property int pressPosY: 0
                anchors.fill: parent
                preventStealing: true
                onClicked: {
                    pressPosX = mouse.x
                    pressPosY = mouse.y
                }
                onPositionChanged: {
                    var new_width = shot_area.width - mouse.x - pressPosX
                    var new_height = shot_area.height + mouse.y - pressPosY
                    if (new_width >= control.areaMinSize) {
                        shot_area.width = new_width
                        shot_area.x += mouse.x - pressPosX
                        if (shot_area.x < 0) {
                            shot_area.width += shot_area.x
                            shot_area.x = 0
                        }
                    }
                    if (new_height >= control.areaMinSize) {
                        shot_area.height = new_height
                        if (shot_area.y + shot_area.height > control.height) {
                            shot_area.height = control.height - shot_area.y
                        }
                    }
                }
            }
        }
        Rectangle {
            width: control.indicatorWidth
            height: control.indicatorWidth
            radius: control.indicatorWidth / 2
            color: control.indicatorColor
            anchors{
                right: parent.right
                bottom: parent.bottom
                margins: -radius
            }
            MouseArea {
                property int pressPosX: 0
                property int pressPosY: 0
                anchors.fill: parent
                preventStealing: true
                onClicked: {
                    pressPosX = mouse.x
                    pressPosY = mouse.y
                }
                onPositionChanged: {
                    var new_width = shot_area.width + mouse.x - pressPosX
                    var new_height = shot_area.height + mouse.y - pressPosY
                    if (new_width >= control.areaMinSize) {
                        shot_area.width = new_width
                        if (shot_area.x + shot_area.width > control.width) {
                            shot_area.width = control.width - shot_area.x
                        }
                    }
                    if (new_height >= control.areaMinSize) {
                        shot_area.height = new_height
                        if (shot_area.y + shot_area.height > control.height) {
                            shot_area.height = control.height - shot_area.y
                        }
                    }
                }
            }
        }
    }
}
