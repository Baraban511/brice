import { App, Astal, Gtk, Gdk } from "astal/gtk3";
import { Variable, GLib, bind } from "astal";
import Battery from "gi://AstalBattery";
import Wp from "gi://AstalWp";
import Mpris from "gi://AstalMpris";
import Network from "gi://AstalNetwork";
import Hyprland from "gi://AstalHyprland";

function MultiBox() {
  const mpris = Mpris.get_default();
  return (
    <box className="fademedia">
      {bind(mpris, "players").as((ps) => (ps[0] ? <Media /> : <Workspaces />))}
    </box>
  );
}

function Workspaces() {
  const hypr = Hyprland.get_default();

  return (
    <box className="Workspaces">
      {bind(hypr, "workspaces").as((workspaces) =>
        workspaces
          .filter((ws) => !(ws.id >= -99 && ws.id <= -2)) // filter out special workspaces
          .sort((a, b) => a.id - b.id)
          .map((workspace) => (
            <button
              className={bind(hypr, "focusedWorkspace").as(
                (focusedWorkspace) =>
                  workspace === focusedWorkspace ? "focused" : "",
              )}
              onClicked={() => workspace.focus()}
            >
              {workspace.id}
            </button>
          )),
      )}
    </box>
  );
}

function Wifi() {
  const { wifi } = Network.get_default();

  return (
    <icon
      tooltipText={bind(wifi, "ssid").as(String)}
      className="Wifi space"
      icon={bind(wifi, "iconName")}
    />
  );
}

function AudioSlider() {
  const speaker = Wp.get_default()?.audio.defaultSpeaker!;

  return (
    <box className="AudioSlider" css="min-width: 140px">
      <icon icon={bind(speaker, "volumeIcon")} />
      <slider
        hexpand
        onDragged={({ value }) => (speaker.volume = value)}
        value={bind(speaker, "volume")}
      />
    </box>
  );
}

function Time({ format = "%H:%M - %A %e" }) {
  const time = Variable<string>("").poll(
    1000,
    () => GLib.DateTime.new_now_local().format(format)!,
  );

  return (
    <label className="Time" onDestroy={() => time.drop()} label={time()} />
  );
}
function Media() {
  const mpris = Mpris.get_default();

  return (
    <box className="Media">
      {bind(mpris, "players").as((ps) =>
        ps[0] ? (
          <box>
            <box
              className="Cover"
              valign={Gtk.Align.CENTER}
              css={bind(ps[0], "coverArt").as(
                (cover) => `background-image: url('${cover}');`,
              )}
            />
            <label
              label={bind(ps[0], "metadata").as(
                () => `${ps[0].title} - ${ps[0].artist}`,
              )}
            />
          </box>
        ) : (
          <label label="Nothing Playing" />
        ),
      )}
    </box>
  );
}

function BatteryLevel() {
  const bat = Battery.get_default();

  return (
    <box className="Battery" visible={bind(bat, "isPresent")}>
      <icon icon={bind(bat, "batteryIconName")} className="space" />
      <label
        label={bind(bat, "percentage").as((p) => `${Math.floor(p * 100)} %`)}
      />
    </box>
  );
}

export default function Bar(monitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      className="Bar"
      gdkmonitor={monitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
    >
      <centerbox>
        <box hexpand halign={Gtk.Align.START}>
          <Time />
          <Wifi />
        </box>
        <box>
          <MultiBox />
        </box>
        <box hexpand halign={Gtk.Align.END}>
          <BatteryLevel />
        </box>
      </centerbox>
    </window>
  );
}
