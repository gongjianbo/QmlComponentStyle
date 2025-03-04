QT += quick
QT += qml
QT += quickcontrols2

CONFIG += c++11
CONFIG += utf8_source
# msvc {
#     QMAKE_CFLAGS += /utf-8
#     QMAKE_CXXFLAGS += /utf-8
# }

CONFIG(debug, debug|release){
# debug setting
} else {
# release setting
}

DESTDIR = $$PWD/bin

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += \
    main.cpp

RESOURCES += qml.qrc

OTHER_FILES += \
    LICENSE \
    README.md

INCLUDEPATH += $$PWD/BasicComponent
include($$PWD/BasicComponent/BasicComponent.pri)

INCLUDEPATH += $$PWD/CustomComponent
include($$PWD/CustomComponent/CustomComponent.pri)

INCLUDEPATH += $$PWD/Tools
include($$PWD/Tools/Tools.pri)

INCLUDEPATH += $$PWD/Image
include($$PWD/Image/Image.pri)
