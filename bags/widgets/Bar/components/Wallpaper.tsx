import { exec } from "ags/process";
export default function Wallpaper() {
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
