import { Gtk } from "ags/gtk4";
import { createPoll } from "ags/time";
import GLib from "gi://GLib";

export default function Time({ format = "%H:%M - %A %e" }) {
  const time = createPoll("", 1000, () => {
    return GLib.DateTime.new_now_local().format(format)!;
  });
  return (
    <menubutton>
      <label class="margin-x padding-y" label={time} />
      <popover>
        <Gtk.Calendar />
      </popover>
    </menubutton>
  );
}
