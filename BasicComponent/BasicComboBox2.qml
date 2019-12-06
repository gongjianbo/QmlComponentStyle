import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12

//2019-12-6 对上一版本下拉框的改进
//qtquickcontrols2\src\imports\controls\ComboBox.qml
//from Customizing ComboBox
T.ComboBox {
    id:control

    //checked选中状态，down按下状态，hovered悬停状态
    property color backgroundTheme: "darkCyan"
    //下拉框背景色
    property color backgroundColor: control.down
                                    ? Qt.darker(backgroundTheme)
                                    : control.hovered
                                      ? Qt.lighter(backgroundTheme)
                                      : backgroundTheme
    //item高亮颜色
    property color itemHighlightColor: Qt.darker(backgroundTheme)
    //item普通颜色
    property color itemNormalColor: backgroundTheme
    //每个item的高度
    property int itemHeight: height
    //每个item文本的左右padding
    property int itemPadding: 10
    //下拉按钮颜色
    //property color indicatorColor: "white"
    //下拉按钮左右距离
    property int indicatorPadding: 8
    //下拉按钮图标
    property url indicatorSource
    //圆角
    property int radius: 0
    //最多显示的item个数
    property int showCount: 5
    //文字颜色
    property color textColor: "white"
    //model数据左侧附加的文字
    property string textLeft: ""
    //model数据右侧附加的文字
    property string textRight: ""


    implicitWidth: 120
    implicitHeight: 30
    spacing: 0
    leftPadding: padding
    rightPadding: padding + indicator.width + spacing
    font{
        family: "SimSun"
        pixelSize: 16
    }

    //各item
    //这里没用ItemDelegate是因为高度不够的时候没显示文字（如24px）
    delegate: T.AbstractButton {
        id: box_item
        height: control.itemHeight
        //Popup如果有padding，这里要剪掉2*pop.padding
        width: control.width
        contentItem: Text {
            text: control.textLeft+
                  (control.textRole
                   ? (Array.isArray(control.model)
                      ? modelData[control.textRole]
                      : model[control.textRole])
                   : modelData)+
                  control.textRight
            color: control.textColor
            leftPadding: control.itemPadding
            rightPadding: control.itemPadding
            font: control.font
            elide: Text.ElideRight
            renderType: Text.NativeRendering
            verticalAlignment: Text.AlignVCenter
        }
        hoverEnabled: control.hoverEnabled
        background: Rectangle{
            radius: control.radius
            color: (control.highlightedIndex === index)
                   ? control.itemHighlightColor
                   : control.itemNormalColor
            Rectangle{
                height: 1
                width: parent.width-2*control.radius
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                color: Qt.lighter(control.itemNormalColor)
            }
        }
    }

    //之前用的Shape，现在替换为Image
    //图标自己画比较麻烦，还是贴图方便，使用的时候换成自己图
    indicator: Item{
        id: box_indicator
        x: control.width - width - control.padding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: box_indicator_img.width+control.indicatorPadding*2
        height: control.height
        //按钮图标
        Image {
            id: box_indicator_img
            anchors.centerIn: parent
            //width: height
            //height: control.height
            //fillMode: Image.PreserveAspectFit
            source: control.indicatorSource
        }
        //分割线
        Rectangle{
            width: 1
            height: parent.height
            anchors.left: parent.left
            color: control.textColor
        }
    }

    //box显示item
    contentItem: T.TextField{
        //control的leftPadding会挤过来，不要设置control的padding
        leftPadding: control.itemPadding
        rightPadding: control.itemPadding
        text: control.editable
              ? control.editText
              : (control.textLeft+control.displayText+control.textRight)
        font: control.font
        color: control.textColor
        verticalAlignment: Text.AlignVCenter
        //默认鼠标选取文本设置为false
        selectByMouse: true
        //选中文本的颜色
        selectedTextColor: "green"
        //选中文本背景色
        selectionColor: "white"
        clip: true
        //renderType: Text.NativeRendering
        enabled: control.editable
        autoScroll: control.editable
        readOnly: control.down
        inputMethodHints: control.inputMethodHints
        validator: control.validator
        renderType: Text.NativeRendering
        background: Rectangle {
            visible: control.enabled && control.editable
            border.width: parent && parent.activeFocus ? 1 : 0
            border.color: control.itemHighlightColor
            color: "transparent"
        }
    }

    //box框背景
    background: Rectangle {
        implicitWidth: control.implicitWidth
        implicitHeight: control.implicitHeight
        radius: control.radius
        color: control.backgroundColor
    }

    //弹出框
    popup: T.Popup {
        //默认向下弹出，如果距离不够，y会自动调整（）
        y: control.height
        width: control.width
        //根据showCount来设置最多显示item个数
        implicitHeight: (control.delegateModel.count<showCount
                         ?contentItem.implicitHeight
                         :5*control.implicitHeight)+2
        //用于边框留的padding
        padding: 1
        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex
            snapMode: ListView.SnapToItem //按行滚动
            //ScrollBar.horizontal: ScrollBar { visible: false }
            ScrollBar.vertical: ScrollBar { //定制滚动条
                id: box_bar
                implicitWidth: 10
                visible: (control.delegateModel.count>showCount)
                //background: Rectangle{} //这是整体的背景
                contentItem: Rectangle{
                    implicitWidth:10
                    radius: width/2
                    color: box_bar.pressed
                           ? Qt.rgba(0.6,0.6,0.6)
                           : Qt.rgba(0.6,0.6,0.6,0.5)
                }
            }
        }

        //弹出框背景（只有border显示出来了，其余部分被delegate背景遮挡）
        background: Rectangle{
            color: control.itemNormalColor
            radius: control.radius
            border.width: 1
            border.color: Qt.lighter(control.itemNormalColor)
        }
    }
}
