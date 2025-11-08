pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Services.SystemTray
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets

Item {
    id: root
    Layout.alignment: Qt.AlignRight
    implicitWidth: 190
    Layout.fillHeight: true
    RowLayout {
        anchors.fill: parent
        spacing: 5
        Repeater {
            model: SystemTray.items
            Rectangle {
                id: trayRect
                required property SystemTrayItem modelData
                Layout.fillHeight: true
                Layout.preferredWidth: 30
                radius: 6
                color: trayArea.containsMouse ? "#7f000000" : "#212223"
                // Text {
                //     anchors.centerIn: parent
                //     text: trayRect.modelData.title
                // }
                MouseArea {
                    id: trayArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: popupWindow.visible = !popupWindow.visible
                    IconImage {
                        anchors.centerIn: trayArea
                        source: trayRect.modelData.icon
                        width: 16
                        height: 16
                    }
                    PopupWindow {
                        id: popupWindow
                        anchor.window: barWindow
                        anchor.rect.x: parentWindow.width / 2 - width / 2
                        anchor.rect.y: parentWindow.height
                        implicitWidth: 500
                        implicitHeight: 500
                        visible: false
                        color: "#7f000000"
                    }
                    // QsMenuAnchor {
                    //     id: trayMenu
                    //     menu: trayRect.modelData.menu

                    //     anchor {
                    //         item: trayRect
                    //         edges: Edges.Right | Edges.Bottom
                    //         gravity: Edges.Left | Edges.Bottom
                    //         adjustment: PopupAdjustment.All
                    //     }
                    // }
                }
            }
        }
    }
}
