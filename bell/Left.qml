pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io

Item {
    id: root
    implicitWidth: 190
    Layout.fillHeight: true
    readonly property string time: {
        // The passed format string matches the default output of
        // the `date` command.
        //clock.date.toLocaleDateString(Qt.locale("fr_FR"));
        Qt.formatDateTime(clock.date, "hh:mm - ddd dd MMM");
    }
    RowLayout {
        anchors.fill: parent
        spacing: 5
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
                    source: "icons/reload-wallpaper.svg"
                    width: 16
                    height: 16
                }
            }
        }
        Rectangle {
            color: "#212223"
            Layout.fillWidth: true
            Layout.fillHeight: true
            radius: 6
            Text {
                anchors.centerIn: parent
                text: root.time
                color: "#ffffff"
                font.pointSize: 12
                font.weight: Font.DemiBold
            }
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

    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
