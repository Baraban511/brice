pragma ComponentBehavior: Bound
import Quickshell
import QtQuick
import QtQuick.Layouts

Scope {
    Variants {
        model: Quickshell.screens
        PanelWindow {
            id: barWindow
            property string type: Quickshell.env("BELL_TYPE")
            required property var modelData
            screen: modelData
            implicitHeight: 30
            anchors {
                top: (type == "portable" ? false : true)
                left: true
                right: true
                bottom: (type == "portable" ? true : false)
            }
            color: (type == "portable" ? "#DD000000" : "transparent")
            RowLayout {
                anchors.fill: parent
                anchors {
                    topMargin: (barWindow.type == "portable" ? 0 : 5)
                    leftMargin: 5
                    rightMargin: 5
                }
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
