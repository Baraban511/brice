import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts
import Quickshell

Scope {

    NotificationServer {
        id: notifServer
        bodyMarkupSupported: true
        actionsSupported: true
        persistenceSupported: true
        imageSupported: true
        inlineReplySupported: true
        onNotification: notification => notification.tracked = true
    }
    PanelWindow {
        anchors {
            right: true
            top: true
        }
        margins {
            top: 7
            right: 7
        }
        focusable: true
        implicitHeight: (100 + 5) * repeater.count - 5
        implicitWidth: 300
        color: "transparent"
        ColumnLayout {
            Layout.alignment: Qt.AlignRight
            Repeater {
                id: repeater
                model: notifServer.trackedNotifications
                Popup {
                    required property Notification modelData
                    notification: modelData
                }
            }
        }
    }
}
