import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent

        PullDownMenu {
            MenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }

            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
        }

        contentHeight: column.height + Theme.paddingLarge

        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge

            PageHeader {
                title: qsTr("OSM Scout Server")
            }

            SectionHeader {
                text: qsTr("Database")
                font.pixelSize: Theme.fontSizeLarge
            }

            ListItem {
                id: listItem
                contentHeight: Theme.itemSizeSmall

                Label {
                    id: database
                    x: Theme.horizontalPageMargin
                    width: parent.width-2*Theme.horizontalPageMargin
                    wrapMode: Text.WordWrap
                    color: listItem.highlighted ? Theme.highlightColor : Theme.primaryColor
                    text: ""

                    function setText() {
                        text = settings.valueString(settingsOsmPrefix + "map")
                    }

                    Component.onCompleted: { setText() }
                    Connections { target: settings; onOsmScoutSettingsChanged: database.setText() }
                }

                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }

            SectionHeader {
                text: qsTr("Events")
                font.pixelSize: Theme.fontSizeMedium
            }

            Label {
                id: log
                x: Theme.horizontalPageMargin
                width: parent.width-2*Theme.horizontalPageMargin
                color: Theme.highlightColor
                font.pixelSize: Theme.fontSizeSmall
                wrapMode: Text.WordWrap

                text: ""

                function setText() {
                    text = logger.log
                }

                Component.onCompleted: { setText() }
                Connections { target: logger; onLogChanged: log.setText() }
            }
        }

        VerticalScrollDecorator {}
    }
}
