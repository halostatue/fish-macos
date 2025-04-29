# @halostatue/fish-macos/functions/finder.fish:v7.0.1

function __macos_finder_defaults::query
    set --query argv[1]
    or return 1

    set --function value (defaults read com.apple.Finder $argv[1] 2>/dev/null)
    or return 1

    switch $value
        case 1
            true
        case '*'
            false
    end
end

function __macos_finder_defaults::set
    set --query argv[1]
    or return 1

    set --query argv[2]
    or return 1

    defaults write com.apple.Finder $argv[1] -bool $argv[2]
    and killall Finder
end

function __macos_finder_pwd::get
    set --function window 1

    if set --query argv[1]
        set window $argv[1]
    end

    echo 'tell application "Finder"
  if ('$window' <= (count Finder windows)) then
    get POSIX path of (target of window '$window' as alias)
  else
    get POSIX path of (desktop as alias)
  end if
end tell' | osascript
end
function __macos_finder_pwd::update
    argparse --exclusive column,list,icon column list icon -- $argv
    or return 1

    set --function window_count 1
    set --function view ''
    set --function view_type ''

    if set --query _flag_column
        set view_type column
    else if set --query _flag_list
        set view_type list
    else if set --query _flag_icon
        set view_type icon
    end

    if test $view_type != ''
        set view 'set the current view of the front Finder window to '$view_type' view'
    end

    set --query argv[1]; and set window_count $argv[1]

    echo 'tell application "Finder"
  if ('$window_count' <= (count Finder windows)) then
    set the target of window '$window_count' to (POSIX file "'$PWD'") as string
  else
    open (POSIX file "'$PWD'") as string
  end if
 ' $view '
end tell' | osascript >/dev/null
end

# Based on bashfinder: https://github.com/NapoleonWils0n/bashfinder.git
# and my port to zsh.
function finder --description 'Manipulate the finder with the current shell'
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

    set --function verb (string lower -- $argv[1])
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
            __macos_finder_pwd::get $argv[1]
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
