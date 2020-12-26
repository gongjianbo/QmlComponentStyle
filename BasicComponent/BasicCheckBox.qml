import QtQuick 2.12
import QtQuick.Templates 2.12 as T
import QtQuick.Controls 2.12
import QtQuick.Controls.impl 2.12

//qtquickcontrols2\src\imports\controls\CheckBox.qml
//from Customizing CheckBox
//2020-12-26 移除Shape，改用impl中的ColorImage加载按钮图标
T.CheckBox {
    id:control

    //可以像源码一样，定义一个全局的样式，然后取全局样式中对应的颜色
    //checked选中状态，down按下状态，hovered悬停状态
    property color textColor: "white"
    property color backgroundTheme: "darkCyan"
    property color backgroundColor: control.down
                                    ? Qt.darker(backgroundTheme)
                                    : (control.hovered||control.highlighted)
                                      ? Qt.lighter(backgroundTheme)
                                      : control.checked
                                        ? backgroundTheme
                                        : backgroundTheme
    property int indicatorWidth: 24 //勾选框
    property color indicatorColor: control.textColor
    property int radius: 0

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
            color: control.textColor
            //这个资源是control默认提供的
            source: "qrc:/qt-project.org/imports/QtQuick/Controls.2/images/check.png"
            visible: control.checkState === Qt.Checked
        }
        Rectangle {
            anchors.centerIn: parent
            width: parent.width/2
            height: parent.height/2
            color: control.textColor
            visible: control.checkState === Qt.PartiallyChecked
        }
    }

    //勾选框文本
    contentItem: CheckLabel {
        text: control.text
        font: control.font
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
        color: backgroundColor
    }
}
