pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Services.SystemTray

Repeater {
    model: SystemTray.items
    Rectangle {
        id: trayRect
        required property SystemTrayItem modelData
        width: 30
        height: 30
        radius: 6
        color: trayArea.containsMouse ? "#7f000000" : "#212223"

        MouseArea {
            id: trayArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: trayRect.modelData.display(barWindow, trayArea.x, trayArea.y) //popupWindow.item.visible = !popupWindow.item.visible
            Image {
                anchors.centerIn: trayArea
                source: updateImagePath(trayRect.modelData.icon)
                width: 16
                height: 16
                function updateImagePath(path: string): string {
                    if (path.includes("?path=")) {
                        var tab = path.split("?path=");
                        path = tab[1] + "/" + tab[0].replace("image://icon/", "");
                    }
                    return path;
                }
            }
            // LazyLoader {
            //     id: popupWindow
            //     loading: true
            //     PopupWindow {
            //         anchor.window: barWindow
            //         anchor.rect.x: parentWindow.width / 2 - width / 2
            //         anchor.rect.y: parentWindow.height
            //         implicitWidth: 500
            //         implicitHeight: 500
            //         color: "#7f000000"
            //         Text {
            //             text: trayRect.modelData.title
            //             color: "white"
            //         }
            //         MouseArea {
            //             onClicked: console.log(trayRect.modelData.menu)
            //         }
            //     }
            // }
        }
    }
}
