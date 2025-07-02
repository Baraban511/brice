import app from "ags/gtk4/app";
import BarStyles from "./widgets/Bar/style.scss";
import Bar from "./widgets/Bar/App";
import Notification from "./widgets/Notification/App";
import NotificationStyles from "./widgets/Notification/styles.scss";
import GLib from "gi://GLib";

const env = GLib.getenv("BAGS_TYPE");
const BAGS_TYPE: "pc" | "portable" = env === "portable" ? "portable" : "pc";

app.start({
  instanceName: "bags",
  css: BarStyles,
  icons: `/home/barab/brice/bags/icons`,

  main() {
    app.get_monitors().map((monitor) => Bar(monitor, BAGS_TYPE));
  },
});

app.start({
  instanceName: "notification",
  css: NotificationStyles,
  main() {
    app.get_monitors().map(Notification);
  },
});
