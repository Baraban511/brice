import Quickshell.Services.Notifications
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    required property Notification notification
    color: root.notification.urgency == 2 ? "red" : "#212223"
    width: 300
    height: 100
    radius: 8
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            root.color = "#2c2d2e";
            timer.running = false;
        }
        onExited: {
            root.color = "#212223";
            timer.running = true;
        }
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton
        onClicked: mouse => {
            if (mouse.button == Qt.RightButton || mouse.button == Qt.MiddleButton)
                root.notification.dismiss();
            else
                console.log(root.notification.actions, root.notification.image, root.notification.hasInlineReply);
        }

        ColumnLayout {
            RowLayout {
                Layout.margins: 10
                Image {
                    source: root.notification.appIcon
                    Layout.preferredWidth: 16
                    Layout.preferredHeight: 16
                }
                Text {
                    text: root.notification.summary
                    color: "white"
                    font.pointSize: 12
                    font.weight: Font.Bold
                }

                // MouseArea {
                //     width: 16
                //     height: 16
                //     anchors.fill: parent
                //     anchors.right: parent.right
                //     onClicked: {
                //         root.notification.dismiss();
                //     }
                //     Image {
                //         anchors.centerIn: parent
                //         source: "../icons/dismiss.svg"
                //         width: 16
                //         height: 16
                //     }
                // }
            }
            Rectangle {
                Layout.margins: 10
                Layout.fillWidth: true
                Layout.fillHeight: true
                Text {
                    text: root.notification.body
                    color: "white"
                    elide: Text.ElideLeft
                }
            }
            RowLayout {
                Repeater {
                    model: root.notification.actions
                    Rectangle {
                        id: actionRoot
                        required property var modelData
                        Layout.preferredHeight: 24
                        Layout.preferredWidth: 100
                        Text {
                            text: actionRoot.modelData.text
                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    actionRoot.modelData.invoke();
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    Timer {
        id: timer
        interval: 10000
        running: true
        onTriggered: root.notification.expire()
    }
}
