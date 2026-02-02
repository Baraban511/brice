pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Io

Rectangle {
    Layout.preferredWidth: 30
    Layout.fillHeight: true
    radius: 6
    color: wallpaper.containsMouse ? "#7f000000" : "#212223" //32000000
    MouseArea {
        id: wallpaper
        anchors.fill: parent
        hoverEnabled: true
        onClicked: if (!unsplash.running) {
            swww.running = true;
        }
        Image {
            anchors.centerIn: parent
            source: "../../icons/reload-wallpaper.svg"
            width: 16
            height: 16
        }
    }
    Process {
        id: swww
        command: ["swww", "img", "/home/barab/.config/brice/unsplash.jpg", "--transition-type", "grow", "--transition-pos", "top-left"]
        onStarted: {
            wallust.running = true;
        }
    }
    Process {
        id: wallust
        command: ["wallust", "run", "/home/barab/.config/brice/unsplash.jpg", "-C", "/home/barab/brice/config/wallust/wallust.toml",]
        onExited: {
            unsplash.running = true;
        }
    }
    Process {
        id: unsplash
        command: ["/home/barab/brice/scripts/unsplash.sh"]
    }
}
