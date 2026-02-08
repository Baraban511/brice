pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

Rectangle {
    color: "#212223"
    Layout.fillWidth: true
    Layout.fillHeight: true
    radius: 6
    Text {
        anchors.centerIn: parent
        text: Math.round(UPower.displayDevice.percentage * 100) + "% - " + getRemainingTime(UPower.displayDevice.timeToEmpty)
        color: "#ffffff"
        font.pointSize: 12
        font.weight: Font.Bold
        function getRemainingTime(time: int): string {
            const hour = Math.floor(time / 3600);
            const min = Math.floor((time % 3600) / 60);
            const sec = time % 60;
            if (hour > 0) {
                return hour + "h" + min;
            } else {
                return min + "m" + sec;
            }
        }
    }
}
