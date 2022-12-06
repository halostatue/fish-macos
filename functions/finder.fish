# Based on bashfinder: https://github.com/NapoleonWils0n/bashfinder.git
# and my port to zsh.
function finder -d 'Manipulate the finder with the current shell'
    argparse --stop-nonopt h/help -- $argv

    if set --query _flag_help
        echo 'Usage: finder [options] subcommand [arguments...]

Interacts with the Finder. If a window number parameter is accepted in a
command, the first (front-most) window is number 1. If a lower window is
specified, or no window is specified, that window becomes the first window.

Subcommands:
  cd                Changes to the path of the Finder window
  clean             Removes .DS_Store files
  column            Changes the Finder window to PWD using column view
  desktop-icons     Shows or hides the desktop icons
  hidden            Shows or hides files that are normally hidden from the Finder
  icon              Changes the Finder window to PWD using icon view
  list              Changes the Finder window to PWD using list view
  pushd             Changes to the path of the Finder window with pushd
  pwd               Prints the path of the Finder window
  quarantine        Manages quarantine events
  selected          Print the selected files on the command-line
  track             Makes the first Finder window track with the shell PWD
  untrack           Disables Finder directory tracking
  update            Updates the Finder window to PWD

Options:
  -h, --help               Show this help'
        return 0
    end

    set --local verb (string lower -- $argv[1])
    set --erase argv[1]

    switch $verb
        case cd
            __macos_finder_cd $argv
        case clean
            __macos_finder_clean $argv
        case desktop-icons
            __macos_finder_desktop_icons $argv
        case hidden
            __macos_finder_hidden $argv
        case update
            __macos_finder_update $argv
        case list
            __macos_finder_list $argv
        case icon
            __macos_finder_icon $argv
        case column
            __macos_finder_column $argv
        case pwd
            __macos_finder_pwd_get $argv[1]
        case pushd
            __macos_finder_pushd $argv
        case quarantine
            __macos_finder_quarantine $argv
        case selected
            __macos_finder_selected
        case track
            __macos_finder_track
        case untrack
            __macos_finder_untrack
        case ''
            echo >&2 'finder: No command provided.'
            finder --help >&2
            return 1
        case '*'
            echo $verb
            echo >&2 'finder: Unknown command.'
            finder --help >&2
            return 1
    end
end
