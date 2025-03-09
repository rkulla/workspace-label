-- EDIT the username path to whatever your username is. use absolute paths NOT ~/.workspace-labels
local labels_file = "/Users/<user>/.workspace-labels" -- Stores workspace names
local label_script = "/Users/<user>/tmp/swiftbar-plugins/workspace-label.1s.sh" -- SwiftBar script

-- Get the correct workspace number (sequential)
function getCurrentWorkspaceNumber()
  local screen = hs.screen.primaryScreen()
  local spaceIDs = hs.spaces.allSpaces()[screen:getUUID()]
  local currentSpaceID = hs.spaces.focusedSpace()

  -- Find the current space index
  for index, spaceID in ipairs(spaceIDs) do
    if spaceID == currentSpaceID then
      return index -- 1-based workspace number
    end
  end
  return nil
end

-- Update the SwiftBar label
function updateLabelForCurrentSpace()
  local workspaceNumber = getCurrentWorkspaceNumber()
  if not workspaceNumber then
    hs.alert.show("Error: Could not determine workspace number")
    return
  end

  -- Default label
  local label = "Workspace " .. workspaceNumber

  -- Read custom labels from file
  local file = io.open(labels_file, "r")
  if file then
    for line in file:lines() do
      local index, workspaceLabel = string.match(line, "^(%d+)%s+(.+)$")
      if index == tostring(workspaceNumber) then
        label = workspaceLabel
        break
      end
    end
    file:close()
  end

  -- Show alert in Hammerspoon
  hs.alert.show(label, 1) -- Shows the label for 1 second

  -- Update SwiftBar script
  local script_content = "#!/bin/bash\necho '🖥️ " .. label .. "'\n"
  local script_file = io.open(label_script, "w")
  if script_file then
    script_file:write(script_content)
    script_file:close()
    hs.execute("chmod +x " .. label_script) -- Ensure it's executable
  else
    hs.alert.show("Error: Unable to write to label file")
    return
  end
end

-- Watch for space changes
spaceWatcher = hs.spaces.watcher.new(updateLabelForCurrentSpace)
spaceWatcher:start()

-- Initial update on script load
updateLabelForCurrentSpace()
