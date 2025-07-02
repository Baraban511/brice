import app from "ags/gtk4/app";
import { Astal, Gdk } from "ags/gtk4";
import { createBinding, With } from "ags";
import AstalMpris from "gi://AstalMpris";

import Media from "./components/Media";
import Workspaces from "./components/Workspaces";
import Wallpaper from "./components/Wallpaper";
import Time from "./components/Time";
import Battery from "./components/Battery";
import Wireless from "./components/Wireless";
import Tray from "./components/Tray";

//Widget for CF Warp status

// function BatteryLevel() {
//   const bat = Battery.get_default();
//   const percentage = createBinding(bat, "percentage");
//   return (
//     <box class="opaque" visible={createBinding(bat, "isPresent")}>
//       <image iconName={createBinding(bat, "batteryIconName")} />
//       <With value={percentage}>
//         {(percentage) => <label label={`${Math.floor(percentage * 100)}%`} />}
//       </With>
//     </box>
//   );
// }

function MultiBox() {
  const mpris = AstalMpris.get_default();
  const players = createBinding(mpris, "players");
  return (
    <With value={players}>
      {(players) => (players[0] ? <Media /> : <Workspaces />)}
    </With>
  );
}

export default function Bar(
  gdkmonitor: Gdk.Monitor,
  bagsType: "pc" | "portable",
) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      visible
      name="bar"
      class="bar"
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
