import { App } from "astal/gtk3";
import Bar from "./widget/Bar/App";
import BarStyles from "./widget/Bar/style.scss";
import OSD from "./widget/OSD/App";
import OSDStyles from "./widget/OSD/styles.scss";
import Notif from "./widget/Notifications/App";
import NotifStyles from "./widget/Notifications/styles.scss";
// import Applauncher from "./widget/AppLauncher/App";
// import ApplauncherStyle from "./widget/AppLauncher/styles.scss";
// import MediaPlayer from "./widget/MediaPlayer/App";
// import MediaPlayerStyle from "./widget/MediaPlayer/styles.scss";
import GLib from "gi://GLib";
const BAGS_TYPE: "pc" | "portable" = GLib.getenv("BAGS_TYPE") || "pc";

App.start({
  instanceName: "bar",
  css: BarStyles,
  main() {
    App.get_monitors().map((monitor: any) => Bar(monitor, BAGS_TYPE));
  },
});

App.start({
  instanceName: "notifications",
  css: NotifStyles,
  main() {
    App.get_monitors().map(Notif);
  },
});

App.start({
  instanceName: "osd",
  css: OSDStyles,
  main() {
    App.get_monitors().map(OSD);
  },
});

// App.start({
//   instanceName: "launcher",
//   css: ApplauncherStyle,
//   main: Applauncher,
// });

// App.start({
//   instanceName: "players",
//   css: MediaPlayerStyle,
//   main: () => {
//     new Widget.Window({}, MediaPlayer());
//   },
// });
