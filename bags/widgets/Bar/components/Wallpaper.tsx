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
  async function setUnsplashWallpaper() {
    exec([
      "wallust",
      "run",
      "/home/barab/.config/brice/unsplash.jpg",
      "-C",
      "/home/barab/brice/config/wallust/wallust.toml",
    ]);
    exec([
      "swww",
      "img",
      "/home/barab/.config/brice/unsplash.jpg",
      "--transition-type",
      "grow",
      "--transition-pos",
      "top-left",
    ]);
  }
  setUnsplashWallpaper()
    .then(() => {
      exec("/home/barab/brice/scripts/unsplash.sh");
    })
    .catch((err) => {
      console.error("Failed to set wallpaper:", err);
    });
}
