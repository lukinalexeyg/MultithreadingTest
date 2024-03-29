QT += core widgets

CONFIG += c++17

CONFIG(release, debug|release) {
    CONFIG += optimize_full
}

TARGET = MultithreadingTest

VERSION = 1.0.1

win32-msvc* {
    QMAKE_CFLAGS += /MP
    QMAKE_CXXFLAGS += /MP
    QMAKE_CXXFLAGS += /utf-8
}

QMAKE_TARGET = $${TARGET}
QMAKE_TARGET_PRODUCT = $${TARGET}
QMAKE_TARGET_COPYRIGHT = "Copyright (c) 2021 Alexey Lukin"

DEFINES += APP_NAME=\"\\\"$$QMAKE_TARGET_PRODUCT\\\"\"
DEFINES += APP_VERSION=\\\"$$VERSION\\\"

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
    log.cpp \
    main.cpp \
    mainwindow.cpp

HEADERS += \
    log.h \
    mainwindow.h

include(elements/Elements.pri)
include(workers/Workers.pri)

FORMS += \
    ui/editelementdialog.ui \
    ui/mainwindow.ui

DESTDIR = bin
MOC_DIR = moc
OBJECTS_DIR = obj
RCC_DIR = rcc
UI_DIR = ui

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

win32-msvc* {
    QMAKE_EXTRA_TARGETS += before_build makefilehook
    makefilehook.target = $(MAKEFILE)
    makefilehook.depends = .beforebuild
    PRE_TARGETDEPS += .beforebuild
    before_build.target = .beforebuild
    before_build.depends = FORCE
    before_build.commands = chcp 1251
}
