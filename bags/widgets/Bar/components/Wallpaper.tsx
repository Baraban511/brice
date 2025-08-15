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
    "swww",
    "img",
    "/home/barab/brice/wallpapers/unsplash.jpg",
    "--transition-type",
    "grow",
    "--transition-pos",
    "top-left",
  ]);
  exec("/home/barab/brice/scripts/unsplash.sh");
}
