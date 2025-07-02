import { createBinding, For } from "ags";
import AstalHyprland from "gi://AstalHyprland";

export default function Workspaces() {
  const hypr = AstalHyprland.get_default();
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
