pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import "./Components/" as Components

Item {
    id: root
    implicitWidth: 190
    Layout.fillHeight: true
    RowLayout {
        anchors.fill: parent
        spacing: 5
        Components.Wallpaper {}
        Components.Time {}
    }
}
