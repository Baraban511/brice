pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import "./Components/" as Components

Item {
    id: root
    Layout.alignment: Qt.AlignRight
    implicitWidth: 300
    Layout.fillHeight: true
    RowLayout {
        anchors.fill: parent
        spacing: 5
        Rectangle {
            color: "transparent"
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
        Components.SystemTray {}
        Components.Battery {}
        Components.Inhibiter {}
    }
}
