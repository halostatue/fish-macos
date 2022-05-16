function __macos_finder_help
    echo 'Usage: finder [command]

Interacts with the Finder. If a window number parameter is accepted in a
command, the first (frontmost) window is number 1. If a lower window is
specified, or no window is specified, that window becomes the first window.

Commands:
  track             Makes the first Finder window track with the shell PWD.
                    This should be used in a single shell instance only,
                    and updates only when the PWD value is updated.
  untrack           Disables Finder directory tracking.

  pwd [window#]     Prints the path of the Finder window.
  cd [window#]      Changes to the path of the Finder window.
  pushd [window]    Changes to the path of the Finder window with `pushd`.

  update [window#]  Updates the Finder window to PWD.
  list [window#]    Changes the Finder window to PWD using list view.
  icon [window#]    Changes the Finder window to PWD using icon view.
  column [window#]  Changes the Finder window to PWD using column view.

  hidden [off|on|toggle]

                    Shows or hides files that are normally hidden from the
                    Finder. If not specified, shows the current state.

  desktop-icons [off|on|toggle]

                    Shows or hides the desktop icons. If not specified, shows
                    the current state.

  clean [path...]   Removes .DS_Store files from the paths provided, or the
                    current path if one is not provided.

  quarantine [show] Shows quarantine events by agent and URL.
  quarantine clear  Clears all quarantine events.

  quarantine clean FILE...

                    Removes quarantine attributes from the specified file(s).
                    At least one file is required.

  selected          Print the selected files on the command-line.'
end
