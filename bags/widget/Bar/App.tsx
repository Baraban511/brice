import { Astal, Gtk, Gdk } from "astal/gtk3";
import { Variable, GLib, bind } from "astal";
import Battery from "gi://AstalBattery";
import Mpris from "gi://AstalMpris";
import Hyprland from "gi://AstalHyprland";
import Tray from "gi://AstalTray";
import Network from "gi://AstalNetwork";
// import Wp from "gi://AstalWp";
function Wifi() {
  const { wifi } = Network.get_default();
  // console.log(Network.Primary);
  return (
    <icon
      tooltipText={bind(wifi, "ssid").as(String)}
      className="Wifi space"
      icon={bind(wifi, "iconName")}
    />
  );
}

function SystemTray() {
  var tray = Tray.get_default();
  return (
    <box className="SystemTray">
      {bind(tray, "items").as((items) =>
        items.map((item) => (
          <button
            className="TrayItem"
            onClicked={(event) => console.log("Clicked")}
            tooltipText={
              item.tooltip_markup ||
              item.title[0].toUpperCase() + item.title.slice(1)
            }
          >
            <icon gicon={item.gicon} />
          </button>
        )),
      )}
    </box>
  );
}

function MultiBox() {
  const mpris = Mpris.get_default();
  return (
    <box>
      {bind(mpris, "players").as((ps) => (ps[0] ? <Media /> : <Workspaces />))}
    </box>
  );
}
function Workspaces() {
  const hypr = Hyprland.get_default();

  return (
    <box className="Workspaces fademedia">
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

function Time({ format = "%H:%M - %A %e" }) {
  const time = Variable<string>("").poll(
    1000,
    () => GLib.DateTime.new_now_local().format(format)!,
  );

  return (
    <label
      className="Time space"
      onDestroy={() => time.drop()}
      label={time()}
    />
  );
}
function Media() {
  const mpris = Mpris.get_default();

  return (
    <box className="Media fademedia">
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

export default function Bar(monitor: Gdk.Monitor, bagsType: "pc" | "portable") {
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
          {bagsType === "portable" ? <Time /> : <Media />}
          {bagsType === "portable" ? <Wifi /> : <></>}
        </box>
        <box>
          <></>
          {bagsType === "portable" ? <MultiBox /> : <Workspaces />}
        </box>
        <box hexpand halign={Gtk.Align.END}>
          {bagsType === "portable" ? <BatteryLevel /> : <Time />}
          <SystemTray />
        </box>
      </centerbox>
    </window>
  );
}

// function AudioSlider() {
//   const speaker = Wp.get_default()?.audio.defaultSpeaker!;

//   return (
//     <box className="AudioSlider" css="min-width: 140px">
//       <icon icon={bind(speaker, "volumeIcon")} />
//       <slider
//         hexpand
//         onDragged={({ value }) => (speaker.volume = value)}
//         value={bind(speaker, "volume")}
//       />
//     </box>
//   );
// }
