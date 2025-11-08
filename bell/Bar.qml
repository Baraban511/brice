pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: barWindow
            required property var modelData
            screen: modelData
            implicitHeight: 30
            anchors {
                top: true
                left: true
                right: true
            }
            color: "transparent"
            RowLayout {
                anchors.fill: parent
                anchors.topMargin: 5
                anchors.leftMargin: 5
                anchors.rightMargin: 5
                spacing: 5
                Left {
                    Layout.alignment: Qt.AlignLeft
                }
                Center {
                    Layout.alignment: Qt.AlignCenter
                }

                Right {
                    Layout.alignment: Qt.AlignRight
                }
            }
        }
    }
}
