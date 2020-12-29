import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12

//qtquickcontrols2\src\imports\controls\ComboBox.qml
//from Customizing ComboBox
//2020-12-26 移除Shape，改用impl中的ColorImage加载按钮图标
T.ComboBox {
    id:control

    property color themeColor: "darkCyan"  //主题颜色
    property color indicatorColor: "white" //按钮颜色
    property color textColor: "white"      //文本主颜色
    property int radius: 3
    property int showCount: 5              //最多显示的item个数
    property int indicatorPadding: 0       //下拉按钮边距
    property url indicatorSource: "qrc:/qt-project.org/imports/QtQuick/Controls.2/images/double-arrow.png"

    property Gradient _normalGradient: Gradient{
        GradientStop { position: 0.0; color: Qt.lighter(themeColor) }
        GradientStop { position: 0.5; color: themeColor }
        GradientStop { position: 1.0; color: Qt.lighter(themeColor) }
    }
    property Gradient _downGradient: Gradient{
        GradientStop { position: 0.0; color: Qt.darker(themeColor) }
        GradientStop { position: 0.5; color: themeColor }
        GradientStop { position: 1.0; color: Qt.lighter(themeColor) }
    }
    property Gradient _hoverGradient: Gradient{
        GradientStop { position: 0.0; color: themeColor }
        GradientStop { position: 0.5; color: Qt.darker(themeColor) }
        GradientStop { position: 1.0; color: themeColor }
    }
    property Gradient _lightToNormal: Gradient{
        GradientStop { position: 0.0; color: Qt.lighter(themeColor) }
        GradientStop { position: 0.6; color: themeColor }
    }
    property Gradient _normalToDark: Gradient{
        GradientStop { position: 0.2; color: themeColor }
        GradientStop { position: 0.9; color: Qt.darker(themeColor) }
    }
    //property int _globalY: mapToGlobal(control.x,control.y).y
    //property int _globalHeight: Screen.desktopAvailableHeight

    implicitWidth: 120
    implicitHeight: 30
    spacing: 5
    leftPadding: padding
    rightPadding: padding + indicator.width + spacing
    font{
        family: "SimSun"
        pixelSize: 16
    }

    //各item
    delegate: ItemDelegate {
        implicitWidth: control.implicitWidth
        implicitHeight: control.implicitHeight
        width: control.width
        padding: 0
        contentItem: Text {
            text: control.textRole
                  ? (Array.isArray(control.model)
                     ? modelData[control.textRole]
                     : model[control.textRole])
                  : modelData
            color: control.textColor
            font: control.font
            elide: Text.ElideRight
            renderType: Text.NativeRendering
            verticalAlignment: Text.AlignVCenter
        }
        hoverEnabled: control.hoverEnabled
        background: Rectangle{
            gradient: (control.highlightedIndex === index)
                      ?_normalToDark
                      :_lightToNormal
        }
    }

    //下拉按钮图标
    indicator: Item{
        id: box_indicator
        x: control.width - width
        y: control.topPadding + (control.availableHeight - height) / 2
        width: box_indicator_img.width+control.indicatorPadding*2
        height: control.height
        //按钮图标
        ColorImage {
            id: box_indicator_img
            anchors.centerIn: parent
            color: control.textColor
            source: control.indicatorSource
        }
    }

    //box显示item
    contentItem: T.TextField{
        leftPadding: 10
        rightPadding: 6
        text: control.editable
              ? control.editText
              : control.displayText
        font: control.font
        color: control.textColor
        verticalAlignment: Text.AlignVCenter
        //默认鼠标选取文本设置为false
        selectByMouse: true
        //选中文本的颜色
        selectedTextColor: "white"
        //选中文本背景色
        selectionColor: "black"
        clip: true
        renderType: Text.NativeRendering
        enabled: control.editable
        autoScroll: control.editable
        readOnly: control.down
        inputMethodHints: control.inputMethodHints
        validator: control.validator
        background: Rectangle {
            visible: control.enabled && control.editable
            color: parent && parent.activeFocus
                      ? Qt.rgba(0.6,0.6,0.6,0.6)
                      : "transparent"
        }
    }

    //box框背景
    background: Rectangle {
        implicitWidth: control.implicitWidth
        implicitHeight: control.implicitHeight
        radius: control.radius
        gradient: control.down
                  ? _downGradient
                  : control.hovered
                    ? _hoverGradient
                    : _normalGradient
    }

    //弹出框
    popup: T.Popup {
        //默认向下弹出，如果距离不够，y会自动调整（）
        y: control.height
        width: control.width
        //根据showCount来设置最多显示item个数
        implicitHeight: (control.delegateModel.count<showCount
                         ?contentItem.implicitHeight
                         :control.showCount*control.implicitHeight)+2
        padding: 1
        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.popup.visible ? control.delegateModel : null
            currentIndex: control.highlightedIndex
            //按行滚动SnapToItem ;像素移动SnapPosition
            snapMode: ListView.SnapToItem
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
        background: Rectangle {
            border.width: 1
            border.color: themeColor
            //color: Qt.lighter(themeColor)
            radius: 2
        }
    }
}
