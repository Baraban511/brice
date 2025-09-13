import { createBinding, For } from "ags";
import AstalTray from "gi://AstalTray";
export default function Tray() {
  const tray = AstalTray.get_default();
  const items = createBinding(tray, "items");

  const init = (btn: Gtk.MenuButton, item: AstalTray.TrayItem) => {
    btn.menuModel = item.menuModel;
    btn.insert_action_group("dbusmenu", item.actionGroup);
    item.connect("notify::action-group", () => {
      btn.insert_action_group("dbusmenu", item.actionGroup);
    });
  };

  return (
    <box class="margin-x">
      <For each={items}>
        {(item) => (
          <menubutton $={(self) => init(self, item)} class="tray-item">
            <image gicon={createBinding(item, "gicon")} />
          </menubutton>
        )}
      </For>
    </box>
  );
}
