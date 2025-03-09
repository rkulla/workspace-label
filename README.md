# workspace-label
Label MacOS workspaces

## Description / Requirements

`workspace-label` allows you to create a text file called ~/.workspace-labels where you name your MacOS workspaces. E.g,

```
1 Coding (foo)
2 Coding (bar)
3 Misc
4 Music
```

or whatever you want each MacOS virtual desktop to be called, and when you switch workspaces, [Hamerspoon](https://www.hammerspoon.org/) will read that file and update a [SwiftBar](https://github.com/swiftbar/SwiftBar) plugin (included) that echo's the name of the current workspace, both as a Hammerspoon alert notification on the center of the screen and as the SwiftBar label in the menu bar.

![Description](https://github.com/user-attachments/assets/fc21d5dd-3bb1-4e9f-b619-6084bf5a41c9)

Note: The screenshot above is cropped. I label at the bottom will actually be shown in center of screen. The red rectangles won't be there and are just to highlight the places this project shows your workspace labels.

If your menu bar is cluttered, I recommend a tool like [Bartender](https://www.macbartender.com/) or similar, which is what I'm using. Just make sure to put switchbar in the "always show" section.

## Installation and Setup

1. Install SwiftBar (it's free/open-source)
    ```bash
    brew install swiftbar
    ```
2. Launch SwiftBar.app and set its plugin folder location to `~/swiftbar` when it asks
3. Install HammerSpoon (it's free/open-source)
    ```bash
    brew install --cask hammerspoon
    ```
4. Launch hammerspoon.app and give it permissions when it asks
5. Create a text file called ~/.workspace-labels with the numeric index / personalized labels you want for them. Example, say you have 4 MacOS virtual desktops that you want to label as follows (change the names to whatever you want):
    ```
    1 Coding (foo)
    2 Coding (bar)
    3 Misc
    4 Music
    ```
6. Right-click on hammerspoon's hammer icon in the menu bar and click `Open Config`, which opens init.lua in your editor. Copy the contents from the init.lua included with this repo.
7. You'll have to udpate the top of the init.lua script on your machine to use YOUR username at the top of the script, because it doesn't currently support relative paths or $HOME:
    ```
    /Users/<user>/swiftbar/workspace-label.1s.sh
    ```
then click on Hammerspoon's menubar icon and click `Reload Config`. If it keeps asking for permissions, you may have to toggle them off/on again, restart hammerspoon and possibly reboot (I usually can avoid needing to reboot to fix it by toggling it once or twice).

Note how that created a shell script in the SwiftBar plugins folder, which has a `.1s` in the filename. That's SwiftBar's way of saying to automatically run that script every 1 second, which in this case will simply echo the current workspace's label we assigned to it in ~/.workspace-labels. See: https://github.com/swiftbar/SwiftBar/blob/main/README.md#plugin-naming

