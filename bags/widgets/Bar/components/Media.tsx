// @ts-nocheck
import { Gtk } from "ags/gtk4";
import { createBinding, With, For } from "ags";
import AstalMpris from "gi://AstalMpris";
import AstalApps from "gi://AstalApps";

export default function Media() {
  const mpris = AstalMpris.get_default();
  const players = createBinding(mpris, "players");
  return (
    <box class="opaque">
      <For each={players}>
        {(player) => (
          <box>
            <image pixelSize={20} file={createBinding(player, "coverArt")} />
            <label label={createBinding(player, "title")} />
            <label label="|" />
            <label label={createBinding(player, "artist")} />
          </box>
        )}
      </For>
    </box>
  );
}
