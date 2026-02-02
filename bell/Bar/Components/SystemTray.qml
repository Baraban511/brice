pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Services.SystemTray
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

Repeater {
    model: SystemTray.items
    Rectangle {
        id: trayRect
        required property SystemTrayItem modelData
        Layout.fillHeight: true
        Layout.preferredWidth: 30
        radius: 6
        color: trayArea.containsMouse ? "#7f000000" : "#212223"

        MouseArea {
            id: trayArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: popupWindow.item.visible = !popupWindow.item.visible
            IconImage {
                anchors.centerIn: trayArea
                source: trayRect.modelData.icon
                width: 16
                height: 16
            }
            LazyLoader {
                id: popupWindow
                loading: true
                PopupWindow {
                    anchor.window: barWindow
                    anchor.rect.x: parentWindow.width / 2 - width / 2
                    anchor.rect.y: parentWindow.height
                    implicitWidth: 500
                    implicitHeight: 500
                    color: "#7f000000"
                    Text {
                        text: trayRect.modelData.title
                    }
                }
            }
        }
    }
}
