QT += quick virtualkeyboard

#QT += positioning
QT += core gui quick qml positioning location network quickcontrols2
CONFIG += c++11

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0
DEFINES += QT_DEPRECATED_WARNINGS
SOURCES += \
        antenne.cpp \
        hexagone.cpp \
        main.cpp \
        point.cpp \
        vehicule.cpp

HEADERS += \
    antenne.h \
    hexagone.h \
    point.h \
    vehicule.h

#RESOURCES += qml.qrc
RESOURCES += \
    main.qml \
    hexagone.qml \

# Additional import path used to resolve QML modules in Qt Creator's code model
#QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
#QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target






DISTFILES += \
    hexagone.qml \
    main.qml

