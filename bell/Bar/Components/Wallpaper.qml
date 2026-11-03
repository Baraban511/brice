pragma ComponentBehavior: Bound
import QtQuick
import Quickshell.Io

Rectangle {
    width: 30
    height: 30
    radius: 6
    color: wallpaper.containsMouse ? "#7f000000" : "#212223" //32000000
    MouseArea {
        id: wallpaper
        anchors.fill: parent
        hoverEnabled: true
        onClicked: if (!awww.running) {
            awww.running = true;
        }
        Image {
            anchors.centerIn: parent
            source: awww.running ? "../../icons/tabler-dots.svg" : "../../icons/reload-wallpaper.svg"
            width: 16
            height: 16
        }
    }
    Process {
        id: awww
        command: ["wallpaper"]
    }
}
