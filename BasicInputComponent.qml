import QtQuick 2.15
import QtQuick.Controls 2.15

// 因为输入控件的设置项比较多，所以我多写点注释
// 两个普通编辑控件，基础的Textlnput和Control模块TextField
// 两个支持富文本编辑的控件，基础的TextEdit和Control模块TextArea
// 滚动条小问题，点击所在行才有焦点，除了TextArea
// 此外TextField和TextArea默认可以被全局tab切换焦点
Column {
    spacing: 10

    Text {
        width: 90
        height: 30
        verticalAlignment: Text.AlignVCenter
        renderType: Text.NativeRendering
        text: "Basic Input Component"
    }

    Row {
        id: textedit_row
        spacing: 10

        Text {
            width: 90
            height: 30
            renderType: Text.NativeRendering
            text: "TextEdit:"
        }

        // Qt\qt-everywhere-src-5.12.4\qtdeclarative\src\quick\items\qquicktextedit_p.h
        ScrollView {
            id: textedit_1_view
            width: 200
            height: 60
            background: Rectangle {
                border.color: textedit_1.activeFocus ? "blue" : "black"
                border.width: textedit_1.activeFocus ? 2 : 1
            }
            clip: true
            ScrollBar.horizontal: ScrollBar { visible: false }

            TextEdit {
                id: textedit_1
                width: textedit_1_view.width
                padding: 5
                color: "black"
                text: "<p>Gong Jian Bo</p>"
                // 支持富文本
                textFormat: TextEdit.RichText
                // 光标样式是可以自定义的
                // cursorVisible: focus
                // 鼠标选取文本默认为false
                selectByMouse: true
                // 键盘选取文本默认为true
                selectByKeyboard: true
                // 选中文本的颜色
                selectedTextColor: "white"
                // 选中文本背景色
                selectionColor: "black"
                // 超出宽度时开启允许滚动，默认为true
                // 字体的属性也比较多，可以自行看文档
                font{
                    family: "SimSun"
                    pixelSize: 16
                }
                // 截取超出部分
                // clip: true
                // 默认Text.QtRendering看起来比较模糊
                renderType: Text.NativeRendering
                // 文本换行，默认NoWrap
                wrapMode: TextEdit.Wrap

                // 其他
                // 富文本链接相关的我就不写了
            }
        }
    }

    Row {
        id: textarea_row
        spacing: 10

        Text {
            width: 90
            height: 30
            renderType: Text.NativeRendering
            text: "TextArea:"
        }

        ScrollView {
            id: textarea_1_view
            width: 200
            height: 60
            background: Rectangle {
                border.color: textarea_1.activeFocus ? "blue" : "black"
                border.width: textarea_1.activeFocus ? 2 : 1
            }
            clip: true
            ScrollBar.horizontal: ScrollBar { visible: false }

            // Qt\qt-everywhere-src-5.12.4\qtquickcontrols2\src\imports\controls\TextArea.qml
            // Qt\qt-everywhere-src-5.12.4\qtquickcontrols2\src\quicktemplates2\qquicktextarea_p.h
            TextArea{
                id: textarea_1
                width: textarea_1_view.width
                padding: 5
                color: "black"
                // 无输入时的提示文本
                placeholderText: "Gong Jian Bo"
                placeholderTextColor: "gray"
                // text: "<p>Gong Jian Bo</p>"
                // 支持富文本
                textFormat: TextEdit.RichText
                // 光标样式是可以自定义的
                // cursorVisible: focus
                // 鼠标选取文本默认为false
                selectByMouse: true
                // 键盘选取文本默认为true
                selectByKeyboard: true
                // 选中文本的颜色
                selectedTextColor: "white"
                // 选中文本背景色
                selectionColor: "black"
                // 超出宽度时开启允许滚动，默认为true
                // 字体的属性也比较多，可以自行看文档
                font{
                    family: "SimSun"
                    pixelSize: 16
                }
                // 截取超出部分
                // clip: true
                // 默认Text.QtRendering看起来比较模糊
                renderType: Text.NativeRendering
                // 文本换行，默认NoWrap
                wrapMode: TextEdit.Wrap
            }
        }
    }
}
