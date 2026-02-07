pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell

Rectangle {
    id: time
    readonly property string time: {
        // The passed format string matches the default output of
        // the `date` command.
        //clock.date.toLocaleDateString(Qt.locale("fr_FR"));
        Qt.formatDateTime(clock.date, "hh:mm - ddd dd MMM");
    }
    color: "#212223"
    Layout.fillWidth: true
    Layout.fillHeight: true
    radius: 6
    Text {
        anchors.centerIn: parent
        text: time.time
        color: "#ffffff"
        font.pointSize: 12
        font.weight: Font.Bold
    }
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
