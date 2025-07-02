import { createBinding, For } from "ags";
import AstalTray from "gi://AstalTray";
export default function Tray() {
  var tray = AstalTray.get_default();
  var items = createBinding(tray, "items");
  return (
    <box class="margin-x">
      <For each={items}>
        {(item) => (
          <menubutton
            tooltipMarkup={item.tooltip_markup}
            //actionGroup={["dbusmenu", createBinding(item, "actionGroup")]}
            $={(self) => {
              self.insert_action_group("dbusmenu", item.actionGroup);
            }}
            menuModel={item.menu_model}
            class="tray-item"
          >
            <image gicon={createBinding(item, "gicon")} />
          </menubutton>
        )}
      </For>
    </box>
  );
}
