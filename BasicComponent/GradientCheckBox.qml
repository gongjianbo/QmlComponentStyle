import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12

//qtquickcontrols2\src\imports\controls\CheckBox.qml
//from Customizing CheckBox
//2020-12-26 移除Shape，改用impl中的ColorImage加载按钮图标
T.CheckBox {
    id:control

    property color themeColor: "darkCyan"  //主题颜色
    property color textColor: "white"      //文本颜色
    property int indicatorWidth: 24 //勾选框
    property color indicatorColor: control.textColor
    property int radius: 3

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

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 5
    spacing: 5
    font{
        family: "SimSun"
        pixelSize: 16
    }

    //勾选框，用贴图更方便
    indicator: Rectangle {
        implicitWidth: control.indicatorWidth
        implicitHeight: control.indicatorWidth
        x: control.text ? control.leftPadding : control.leftPadding + (control.availableWidth - width) / 2
        y: (parent.height-height) / 2
        color: "transparent"
        border.width: 1
        border.color: control.indicatorColor
        //ColorImage只是把图的颜色填充为了单色
        ColorImage {
            anchors.fill: parent
            anchors.margins: 1
            color: control.indicatorColor
            //这个资源是control默认提供的
            source: "qrc:/qt-project.org/imports/QtQuick/Controls.2/images/check.png"
            visible: control.checkState === Qt.Checked
        }
        Rectangle {
            anchors.centerIn: parent
            width: parent.width/2
            height: parent.height/2
            color: control.indicatorColor
            visible: control.checkState === Qt.PartiallyChecked
        }
    }

    //勾选框文本
    contentItem: Text {
        text: control.text
        font: control.font
        //opacity: enabled ? 1.0 : 0.3
        //color: control.down ? "red" : "blue"
        color: textColor
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        renderType: Text.NativeRendering
        elide: Text.ElideRight
        leftPadding: control.indicator.width + control.spacing +control.leftPadding
        rightPadding: control.rightPadding
    }

    background: Rectangle{
        radius: control.radius
        gradient: control.down
                    ? _downGradient
                    : control.hovered
                      ? _hoverGradient
                      : _normalGradient
    }
}
