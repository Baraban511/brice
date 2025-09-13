import app from "ags/gtk4/app";
import styles from "./styles.scss";
import Bar from "./widgets/Bar/App";
import Notification from "./widgets/Notification/App";
import GLib from "gi://GLib";
app.start({
  css: styles,
  icons: `/home/barab/brice/bags/icons`,
  gtkTheme: "Adwaita",
  instanceName: "bags",
  main() {
    const monitors = app.get_monitors();
    const env = GLib.getenv("BAGS_TYPE");
    const BAGS_TYPE: "pc" | "portable" = env === "portable" ? "portable" : "pc";
    Notification();
    monitors.map((monitor) => Bar({ gdkmonitor: monitor }, BAGS_TYPE));
  },
});
