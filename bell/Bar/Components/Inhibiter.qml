pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Io

Rectangle {
    Layout.preferredWidth: 30
    Layout.fillHeight: true
    radius: 6
    color: inhibit.running ? "red" : "#212223"
    MouseArea {
        id: wallpaper
        anchors.fill: parent
        hoverEnabled: true
        onClicked: if (!inhibit.running) {
            inhibit.running = true;
        } else {
            inhibit.running = false;
            color: "#212223";
        }
        Image {
            anchors.centerIn: parent
            source: "../../icons/mdi-coffee-outline"
            width: 16
            height: 16
        }
    }
    Process {
        id: inhibit
        running: false
        command: ["..."]
    }
}
