# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-osmscout-server

QT += core gui network

CONFIG += c++11
CONFIG += sailfishapp sailfishapp_no_deploy_qml

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# installs
qml.files = qml
qml.path = /usr/share/$${TARGET}
INSTALLS += qml

stylesheets.files = stylesheets
stylesheets.path = /usr/share/$${TARGET}
INSTALLS += stylesheets

data.files = data
data.path = /usr/share/$${TARGET}
INSTALLS += data

# defines
DEFINES += APP_VERSION=\\\"$$VERSION\\\"
DEFINES += IS_SAILFISH_OS

SOURCES += \
    src/dbmaster.cpp \
    src/main.cpp \
    src/requestmapper.cpp \
    src/appsettings.cpp

OTHER_FILES += qml/osmscout-server.qml \
    qml/cover/CoverPage.qml \
    rpm/osmscout-server.spec \
    translations/*.ts

include(src/httpserver/httpserver.pri)

LIBS += -losmscout_map_qt -losmscout_map -losmscout

HEADERS += \
    src/dbmaster.h \
    src/requestmapper.h \
    src/appsettings.h \
    src/config.h

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256


# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
# TRANSLATIONS += translations/osmscout-server-de.ts

DISTFILES += \
    qml/pages/StartPage.qml \
    qml/pages/AboutPage.qml \
    harbour-osmscout-server.desktop \
    rpm/harbour-osmscout-server.yaml \
    rpm/harbour-osmscout-server.changes.in
