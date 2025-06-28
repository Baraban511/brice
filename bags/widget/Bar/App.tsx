//@ts-nocheck
import Battery from "gi://AstalBattery";
import Hyprland from "gi://AstalHyprland";
import Mpris from "gi://AstalMpris";
import Network from "gi://AstalNetwork";
import Tray from "gi://AstalTray";
import { bind, exec, GLib, Variable } from "astal";
import { Astal, type Gdk, Gtk } from "astal/gtk3";

// import Wp from "gi://AstalWp";

function Wifi() {
	const { wifi } = Network.get_default();
	// console.log(Network.Primary);
	return (
		<icon
			tooltipText={bind(wifi, "ssid").as(String)}
			icon={bind(wifi, "iconName")}
		/>
	);
}

function SystemTray() {
	var tray = Tray.get_default();
	return (
		<box>
			{bind(tray, "items").as((items) =>
				items.map((item) => (
					<menubutton
						tooltipMarkup={bind(item, "tooltipMarkup")}
						usePopover={false}
						actionGroup={bind(item, "actionGroup").as((ag) => ["dbusmenu", ag])}
						menuModel={bind(item, "menuModel")}
						className="tray-item"
					>
						<icon gicon={bind(item, "gicon")} />
					</menubutton>
				)),
			)}
		</box>
	);
}

function Wallpaper() {
  return (
    <box>
      <button onClicked={reloadWallpaper}><icon file="/home/barab/brice/bags/widget/Bar/icon.svg" /></button>
    </box>
  )
}
function reloadWallpaper() {
  exec(["hyprctl", "hyprpaper", "reload", ",/home/barab/brice/wallpapers/unsplash.jpg"]);
  exec("/home/barab/brice/scripts/unsplash.sh");
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
		<box className="Workspaces opaque-box">
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
			className="opaque-box"
			onDestroy={() => time.drop()}
			label={time()}
		/>
	);
}
function Media() {
	const mpris = Mpris.get_default();

	return (
		<box className="Media opaque-box">
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
		<box className="Battery space" visible={bind(bat, "isPresent")}>
			<icon icon={bind(bat, "batteryIconName")} />
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
					{bagsType === "portable" ? <Time /> : (<><Wallpaper /><Media /></>)}
					{bagsType === "portable" ? <Wifi /> : null}
				</box>
				<box>{bagsType === "portable" ? <MultiBox /> : <Workspaces />}</box>
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
