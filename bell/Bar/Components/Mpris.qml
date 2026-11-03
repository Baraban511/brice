import QtQuick
import Quickshell.Services.Mpris

Repeater {
    model: filterPlayers(Mpris.players)

    function filterPlayers(players) {
        for (const player of players.values) {
            if (player.trackArtUrl != "") {
                return player;
            }
        }
    }
    Rectangle {
        id: mPlayer
        width: 30
        height: 30
        radius: 6
        color: control.containsMouse ? "#7f000000" : "#212223"
        required property MprisPlayer modelData
        MouseArea {
            id: control
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.LeftButton | Qt.RightButton

            onClicked: function (mouse) {
                if (mouse.button === Qt.RightButton) {
                    mPlayer.modelData.next();
                } else {
                    mPlayer.modelData.togglePlaying();
                }
            }
            onWheel: function (wheel) {
                if (wheel.angleDelta.y > 0) {
                    mPlayer.modelData.next();
                } else if (wheel.angleDelta.y < 0) {
                    mPlayer.modelData.previous();
                }
            }
            Image {
                anchors.centerIn: parent
                source: mPlayer.modelData.trackArtUrl
                width: 16
                height: 16
            }
        }
    }
}
