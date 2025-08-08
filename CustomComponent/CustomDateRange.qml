import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls 1.4 as Old

// 日期范围选择
// （使用Control1的日历实现）
Rectangle {
    id: control
    implicitWidth: 250
    implicitHeight: 30

    property var beginDate // 起始时间
    property var endDate // 截止时间
    property bool __selectedBegin: true // 当前选中的是起始时间吗
    property date __minDate  // 最小可选时间
    property date __maxDate  // 最大可选时间

    property color normalTextColor: "#3D3E40"
    property color unselectTextColor: normalTextColor
    property color selectTextColor: "#305FDE"

    property alias font: item_center.font
    property alias beginText: item_begin.text
    property alias endText: item_end.text

    Component.onCompleted: {
        let min_date = new Date()
        min_date.setFullYear(1949)
        __minDate = min_date
        let max_date = new Date()
        max_date.setFullYear(3049)
        __maxDate = max_date
    }
    radius: 4
    border.color: "#D8DCE6"

    // 起始日期
    Text {
        id: item_begin
        anchors{
            verticalCenter: parent.verticalCenter
            left: parent.left
            right: item_center.left
            leftMargin: 5
        }
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

        text: beginDate
              ? Qt.formatDate(beginDate, "yyyy-MM-dd")
              : ""
        font: control.font
        color:!item_pop.visible
              ? normalTextColor
              : __selectedBegin
                ? selectTextColor
                : unselectTextColor

        MouseArea {
            anchors.fill: parent
            onClicked: {
                __selectedBegin = true
                selectBeginChange()
                item_pop.open()
            }
        }
    }

    Text {
        id: item_center
        anchors.centerIn: parent
        text: "-"
        color: normalTextColor
        font{
            pixelSize: 14
            family: "Microsoft YaHei"
        }
    }

    // 截止日期
    Text {
        id: item_end
        anchors{
            verticalCenter: parent.verticalCenter
            left: item_center.right
            right: parent.right
            rightMargin: 5
        }
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        text: endDate
              ? Qt.formatDate(endDate, "yyyy-MM-dd")
              : ""
        font: control.font
        color:!item_pop.visible
              ? normalTextColor
              : !__selectedBegin
                ? selectTextColor
                : unselectTextColor

        MouseArea {
            anchors.fill: parent
            onClicked: {
                __selectedBegin = false
                selectBeginChange()
                item_pop.open()
            }
        }
    }

    Popup {
        id:item_pop
        width: 250
        height: 250
        y: control.height + 1
        closePolicy: Popup.CloseOnPressOutsideParent |
                     Popup.CloseOnReleaseOutsideParent |
                     Popup.CloseOnEscape
        background: Old.Calendar {
            id: item_calendar
            anchors.fill: parent
            focus: true
            onClicked: {
                selectDate()
            }
            onDoubleClicked: {
                selectDate()
                item_pop.close()
            }
            function selectDate() {
                if (item_pop.visible) {
                    if (control.__selectedBegin)
                        control.beginDate = selectedDate
                    else
                        control.endDate = selectedDate
                }
            }
        }
    }

    function selectBeginChange() {
        if (__selectedBegin) {
            item_calendar.selectedDate = beginDate
            item_calendar.minimumDate = __minDate
            item_calendar.maximumDate = endDate
        } else {
            item_calendar.selectedDate = endDate
            item_calendar.minimumDate = beginDate
            item_calendar.maximumDate = __maxDate
        }
    }

    function clear() {
        beginDate = undefined
        endDate = undefined
    }
}
