import app from "ags/gtk4/app";
import { Astal, Gtk, Gdk } from "ags/gtk4";
import { createPoll } from "ags/time";
import { createBinding, For, With } from "ags";
import { exec } from "ags/process";

import GLib from "gi://GLib";
import Battery from "gi://AstalBattery";
import Hyprland from "gi://AstalHyprland";
import Mpris from "gi://AstalMpris";
import Network from "gi://AstalNetwork";
import Tray from "gi://AstalTray";

function Wifi() {
  const { wifi } = Network.get_default();
  return (
    <menubutton class="margin-x">
      <image
        iconName={createBinding(wifi, "iconName")}
        tooltipText={createBinding(wifi, "ssid")}
      />
      <popover>
        <box>
          <switch
            active={true}
            onNotifyActive={({ active }) => print(active)}
          />
        </box>
      </popover>
    </menubutton>
  );
}

function Time({ format = "%H:%M - %A %e" }) {
  const time = createPoll(
    GLib.DateTime.new_now_local().format(format)!,
    10000,
    () => GLib.DateTime.new_now_local().format(format)!,
  );
  return (
    <menubutton>
      <label class="margin-x padding-y" label={time} />
      <popover>
        <Gtk.Calendar />
      </popover>
    </menubutton>
  );
}

function Media() {
  const mpris = Mpris.get_default();
  const ps = createBinding(mpris, "players");
  return (
    <box class="Media space opaque">
      <With value={ps}>
        {(ps) =>
          ps[0] ? (
            <box>
              <box
                class="Cover margin-x"
                valign={Gtk.Align.CENTER}
                css={`
                  background-image: url("${ps[0].art_url}");
                `}
              />
              <label label={`${ps[0].title} - ${ps[0].artist}`} />
            </box>
          ) : (
            <label label="Nothing Playing" />
          )
        }
      </With>
    </box>
  );
}

function SystemTray() {
  var tray = Tray.get_default();
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

function Wallpaper() {
  return (
    <box class="margin-x">
      <button onClicked={reloadWallpaper}>
        <image iconName="reload-wallpaper" />
      </button>
    </box>
  );
}
function reloadWallpaper() {
  exec([
    "hyprctl",
    "hyprpaper",
    "reload",
    ",/home/barab/brice/wallpapers/unsplash.jpg",
  ]);
  exec("/home/barab/brice/scripts/unsplash.sh");
}

function BatteryLevel() {
  const bat = Battery.get_default();
  const percentage = createBinding(bat, "percentage");
  return (
    <box class="opaque" visible={createBinding(bat, "isPresent")}>
      <image iconName={createBinding(bat, "batteryIconName")} />
      <With value={percentage}>
        {(percentage) => <label label={`${Math.floor(percentage * 100)}%`} />}
      </With>
    </box>
  );
}

function Workspaces() {
  const hypr = Hyprland.get_default();
  const workspaces = createBinding(hypr, "workspaces").as((workspaces) => {
    workspaces.filter((ws) => !(ws.id >= -99 && ws.id <= -2));
    return workspaces
      .filter((ws) => !(ws.id >= -99 && ws.id <= -2))
      .sort((a, b) => a.id - b.id);
  });
  return (
    <box class="Workspaces opaque margin-x">
      <For each={workspaces}>
        {(workspace) => (
          <button
            class={createBinding(hypr, "focusedWorkspace").as(
              (focusedWorkspace) =>
                workspace === focusedWorkspace ? "focused" : "",
            )}
            onClicked={() => workspace.focus()}
          >
            {workspace.id}
          </button>
        )}
      </For>
    </box>
  );
}
function MultiBox() {
  const mpris = Mpris.get_default();
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
        <box $type="start" halign={Gtk.Align.START}>
          <Wallpaper />
          {bagsType === "portable" ? <Time /> : <Media />}
          {bagsType === "portable" && <Wifi />}
        </box>
        <box $type="center" halign={Gtk.Align.CENTER}>
          {bagsType === "portable" ? <MultiBox /> : <Workspaces />}
        </box>

        <box $type="end" halign={Gtk.Align.END}>
          {bagsType === "portable" ? <BatteryLevel /> : <Time />}
          <SystemTray />
        </box>
      </centerbox>
    </window>
  );
}
