import QtQuick 2.15
import QtQuick.Controls 2.15

// 轮播图
Item {
    id: control

    // 圆圈的宽度
    property int indicatorWidth: 10
    property int indicatorMargin: 10
    // 定时切换间隔
    property alias timerInterval: path_timer.interval
    // 切换动画执行时间
    property alias pathDuration: path_view.highlightMoveDuration
    property alias delegate: path_view.delegate
    property alias model: path_view.model
    // 页数
    property alias count: path_page.count

    PathView {
        id: path_view
        anchors.fill: parent

        // 此属性保存任何时候在路径上可见的项目数。
        // 将pathItemCount设置为undefined将显示路径上的所有项目。
        // 因为path代码的问题，设置为2最合适
        pathItemCount: 2

        // 测试时，把clip去掉就能看到完整的
        clip: true

        // 向前移动，即顺序0 1 2 3
        movementDirection: PathView.Positive

        // 切换的时间
        highlightMoveDuration: 1000

        // 视图中突出显示（当前项目）的首选范围，默认值PathView.StrictlyEnforceRange
        // 配合preferredHighlight的范围0.5 0.5，就能显示在正中，切换更自然
        // highlightRangeMode: PathView.StrictlyEnforceRange

        // 希望当前选定的项位于路径的中间，则将突出显示范围设置为0.5,0.5
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        path: Path {
            startX: -path_view.width / 2
            startY: path_view.height / 2

            PathLine {
                x: path_view.pathItemCount * path_view.width - path_view.width / 2
                y: path_view.height / 2
            }
        }
        onModelChanged: {
            if (path_timer.running) {
                path_timer.restart()
            }
        }

    }
    // 定时切换
    Timer {
        id: path_timer
        running: control.visible
        repeat: true
        interval: 3000
        onTriggered: {
            // 至少两个才切换
            if (path_view.count > 1)
                path_view.currentIndex = (path_view.currentIndex + 1) % path_view.count
        }
    }
    // 右下角小圆圈
    PageIndicator {
        id: path_page
        anchors{
            right: parent.right
            bottom: parent.bottom
            margins: control.indicatorMargin
        }
        count: path_view.count
        currentIndex: path_view.currentIndex
        spacing: control.indicatorWidth
        delegate: Rectangle {
            width: control.indicatorWidth
            height: width
            radius: width / 2
            color: "white"
            // 非当前页就灰色
            opacity: index === path_page.currentIndex ? 1 : 0.6
            Behavior on opacity {
                OpacityAnimator {
                    duration: 200
                }
            }
            // 点击跳转到该页
            // 还有问题，非连续的item，他会快速连续切换到目标index
            // 因为不是直接切换，有闪烁的感觉
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    path_view.currentIndex = index
                    if (path_timer.running) {
                        path_timer.restart()
                    }
                }
            }
        }
    }
}
