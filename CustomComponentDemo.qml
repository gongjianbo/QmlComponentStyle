import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12

//展示自定义组合组件
ScrollView {

    Column{
        anchors{
            left: parent.left
            top: parent.top
            margins: 10
        }
        spacing: 10

        Row{
            spacing: 10
            //普通按钮
            CustomButton{}
            //普通按钮2
            CustomButton2{}
            //开关按钮
            CustomSwitchButton{}
            //桌面右下角弹框
            CustomButton2{
                text: "Pop"
                textColor: "white"
                onClicked: pop.showTip()
                //桌面右下角弹框
                CustomDesktopTip{
                    id: pop
                    title: qsTr("DesktopTip")
                    content: Rectangle{
                        width: 300
                        height: 200
                        color: "green"
                        Text {
                            anchors.centerIn: parent
                            text: qsTr("DesktopTip")
                        }
                        //测试上层也有个MouseArea对对话框的MouseArea影响
                        MouseArea{
                            anchors.fill: parent
                            //目前还不能设置hoverEnabled，不然parent的MouseArea没法判断
                            //hoverEnabled: true
                        }
                    }
                }
            }
        }

        Row{
            spacing: 10
            //音量调节
            CustomVolumeSliderDemo{}
            //Item截图
            CustomItemShotDemo{}
        }

        //轮播图
        CustomCircularViewDemo{}

        //环形进度条
        CustomCircleProgressBar{
            //测试用，循环设置进度值
            NumberAnimation on value {
                from: 0; to: 100
                duration: 5000
                running: true
                loops: Animation.Infinite
            }
        }

        Row{
            spacing: 10
            //日期范围选择
            CustomDateRange{
                id: date_range
                height: 40
                width: 300
            }
            Button{
                text: "\u8fd1\u4e00\u5468" //"近一周"
                onClicked: {
                    let begin_date=new Date();
                    date_range.endDate=new Date();
                    begin_date.setDate(begin_date.getDate()-6)
                    date_range.beginDate=begin_date;
                }
            }
            Button{
                text: "\u8fd1\u4e00\u6708" //"近一月"
                onClicked: {
                    let begin_date=new Date();
                    date_range.endDate=new Date();
                    begin_date.setMonth(begin_date.getMonth()-1);
                    date_range.beginDate=begin_date;
                }
            }
        }

        Row{
            spacing: 10
            CustomLoading{
                running: loading_runing.checked
            }
            CustomLoading2{
                running: loading_runing.checked
            }
            Button{
                id: loading_runing
                checkable: true
                checked: true
                text: checked?"stop":"running"
            }
        }

        //底部空白
        Item{
            width: 100
            height: 500
        }
    }
}
