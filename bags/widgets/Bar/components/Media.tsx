import { Gtk } from "ags/gtk4";
import { createBinding, With } from "ags";
import AstalMpris from "gi://AstalMpris";

export default function Media() {
  const mpris = AstalMpris.get_default();
  const players = createBinding(mpris, "players");
  return (
    <menubutton class="Media space opaque">
      <With value={players}>
        {(player) =>
          player[0] ? (
            <box>
              <image
                pixelSize={24}
                valign={Gtk.Align.CENTER}
                file={createBinding(player[0], "coverArt")}
              />
              <label label={`${player[0].title} - ${player[0].artist}`} />
            </box>
          ) : (
            <label label="Nothing Playing" />
          )
        }
      </With>
    </menubutton>
  );
}

// import Gtk from "gi://Gtk?version=4.0";
// import AstalMpris from "gi://AstalMpris";
// import AstalApps from "gi://AstalApps";
// import { For, With, createBinding } from "ags";
// export default function Mpris() {
//   const mpris = AstalMpris.get_default();
//   const apps = new AstalApps.Apps();
//   const players = createBinding(mpris, "players");

//   return (
//     <menubutton>
//       <box>
//         <For each={players}>
//           {(player) => {
//             const [app] = apps.exact_query(player.entry);
//             return <image visible={!!app.iconName} iconName={app?.iconName} />;
//           }}
//         </For>
//       </box>
//       <popover>
//         <box spacing={4} orientation={Gtk.Orientation.VERTICAL}>
//           <For each={players}>
//             {(player) => (
//               <box spacing={4} widthRequest={200}>
//                 <box overflow={Gtk.Overflow.HIDDEN} css="border-radius: 8px;">
//                   <image
//                     pixelSize={64}
//                     file={createBinding(player, "coverArt")}
//                   />
//                 </box>
//                 <box
//                   valign={Gtk.Align.CENTER}
//                   orientation={Gtk.Orientation.VERTICAL}
//                 >
//                   <label xalign={0} label={createBinding(player, "title")} />
//                   <label xalign={0} label={createBinding(player, "artist")} />
//                 </box>
//                 <box hexpand halign={Gtk.Align.END}>
//                   <button
//                     onClicked={() => player.previous()}
//                     visible={createBinding(player, "canGoPrevious")}
//                   >
//                     <image iconName="media-seek-backward-symbolic" />
//                   </button>
//                   <button
//                     onClicked={() => player.play_pause()}
//                     visible={createBinding(player, "canControl")}
//                   >
//                     <box>
//                       <image
//                         iconName="media-playback-start-symbolic"
//                         visible={createBinding(
//                           player,
//                           "playbackStatus",
//                         )((s) => s === AstalMpris.PlaybackStatus.PLAYING)}
//                       />
//                       <image
//                         iconName="media-playback-pause-symbolic"
//                         visible={createBinding(
//                           player,
//                           "playbackStatus",
//                         )((s) => s !== AstalMpris.PlaybackStatus.PLAYING)}
//                       />
//                     </box>
//                   </button>
//                   <button
//                     onClicked={() => player.next()}
//                     visible={createBinding(player, "canGoNext")}
//                   >
//                     <image iconName="media-seek-forward-symbolic" />
//                   </button>
//                 </box>
//               </box>
//             )}
//           </For>
//         </box>
//       </popover>
//     </menubutton>
//   );
// }
