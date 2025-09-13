import app from "ags/gtk4/app";
import { Astal, Gdk } from "ags/gtk4";
import AstalMpris from "gi://AstalMpris";

import { With, createBinding, onCleanup } from "ags";
import Media from "./components/Media";
import Workspaces from "./components/Workspaces";
import Wallpaper from "./components/Wallpaper";
import Time from "./components/Time";
import Battery from "./components/Battery";
import Wireless from "./components/Wireless";
import Tray from "./components/Tray";

function MultiBox() {
  const mpris = AstalMpris.get_default();
  const players = createBinding(mpris, "players");
  return (
    <With value={players}>
      {(players) => (players ? <Media /> : <Workspaces />)}
    </With>
  );
}

export default function Bar(
  { gdkmonitor }: { gdkmonitor: Gdk.Monitor },
  bagsType: "pc" | "portable",
) {
  let win: Astal.Window;
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  onCleanup(() => {
    // Root components (windows) are not automatically destroyed.
    // When the monitor is disconnected from the system, this callback
    // is run from the parent <For> which allows us to destroy the window
    win.destroy();
  });

  return (
    <window
      visible
      namespace="bar"
      class="Bar"
      name={`bar-${gdkmonitor.connector}`}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={app}
    >
      <centerbox>
        <box $type="start">
          <Wallpaper />
          {bagsType === "portable" ? <Time /> : <Media />}
          {bagsType === "portable" && <Wireless />}
        </box>
        <box $type="center">
          {bagsType === "portable" ? <MultiBox /> : <Workspaces />}
        </box>

        <box $type="end">
          {bagsType === "portable" ? <Battery /> : <Time />}
          <Tray />
        </box>
      </centerbox>
    </window>
  );
}
