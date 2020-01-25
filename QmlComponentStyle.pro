QT += quick
QT += qml

CONFIG += c++11
CONFIG += utf8_source
#msvc {
#    QMAKE_CFLAGS += -source-charset:utf-8
#    QMAKE_CXXFLAGS += -source-charset:utf-8
#}

CONFIG(debug, debug|release){
    DESTDIR = $$PWD/App_Debug
} else {
    DESTDIR = $$PWD/App_Release
}

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

SOURCES += \
        main.cpp

RESOURCES += qml.qrc

OTHER_FILES += LICENSE \
        README.md

include($$PWD/BasicComponent/BasicComponent.pri)
include($$PWD/CustomComponent/CustomComponent.pri)
include($$PWD/Tools/Tools.pri)
include($$PWD/Image/Image.pri)
INCLUDEPATH += $$PWD/BasicComponent
INCLUDEPATH += $$PWD/CustomComponent
INCLUDEPATH += $$PWD/Tools
INCLUDEPATH += $$PWD/Image
