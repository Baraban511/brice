import { Astal, Gtk, Gdk } from "astal/gtk4";
export default function Greeter(monitor: Gdk.Monitor) {
  return (
    <window className="greeter" gdkmonitor={monitor}>
      <box>Content of the widget</box>
    </window>
  );
}
