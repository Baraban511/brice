import QtQuick
import Quickshell.Io
import "." // to import the singleton from qmldir

Rectangle {
    width: 30
    height: 30
    radius: 6
    color: GlobalInhibit.running ? "red" : (wallpaper.containsMouse ? "#7f000000" : "#212223")

    MouseArea {
        id: wallpaper
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            if (!GlobalInhibit.running) {
                GlobalInhibit.running = true;
            } else {
                GlobalInhibit.running = false;
            }
        }
        Image {
            anchors.centerIn: parent
            source: "../../icons/mdi-coffee-outline"
            width: 16
            height: 16
        }
    }
}
