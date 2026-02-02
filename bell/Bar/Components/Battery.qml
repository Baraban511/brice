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
        text: UPower.displayDevice.percentage * 100 + "% - " + UPower.displayDevice.timeToEmpty + "s"
        color: "#ffffff"
        font.pointSize: 12
        font.weight: Font.Bold
    }
}
