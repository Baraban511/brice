pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Rectangle {
    Layout.fillHeight: true
    implicitWidth: workspaceRepeater.count * 30
    color: "#212223"
    radius: 6
    RowLayout {
        anchors.fill: parent
        spacing: 0
        Repeater {
            id: workspaceRepeater
            model: Hyprland.workspaces
            Rectangle {
                id: workspaceRect
                required property HyprlandWorkspace modelData
                color: workspaceArea.containsMouse ? "#121416" : "#212223"
                width: 30
                Layout.fillHeight: true
                radius: 6
                MouseArea {
                    id: workspaceArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        workspaceRect.modelData.activate();
                    }
                }
                Text {
                    anchors.centerIn: parent
                    text: workspaceText(workspaceRect.modelData.name)
                    color: workspaceRect.modelData.active ? "#378df7" : "#f1f1f1"
                    font.pointSize: 12
                    font.weight: Font.DemiBold
                    function workspaceText(text) {
                        if (text == "special:magic")
                            return 0;
                        else
                            return text;
                    }
                }
            }
        }
    }
}
