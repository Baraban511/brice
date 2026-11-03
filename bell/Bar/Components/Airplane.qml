
import QtQuick
import Quickshell.Networking
import Quickshell.Io

Rectangle {
    width: 30
    height: 30
    radius: 6
    color: Networking.wifiEnabled ? (airplane.containsMouse ? "#7f000000" : "#212223") : "red"
    MouseArea {
        id: airplane
        anchors.fill: parent
        hoverEnabled: true
        onClicked: rfkill.running = true
        Image {
            anchors.centerIn: parent
            source: Networking.wifiEnabled ? "../../icons/mdi-wifi" : "../../icons/mdi-airplane"
            width: 16
            height: 16
        }
        Process {
            id: rfkill
            running: false
            command: ["rfkill", "toggle", "all"]
        }
    }
}
