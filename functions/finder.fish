# Based on bashfinder: https://github.com/NapoleonWils0n/bashfinder.git
# and my port to zsh.

function finder:::help
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

function finder::pwd::update
    set -l window_count 1
    set -l view ''
    set -l view_type none
    set -q argv[1]; and set -l view_type (string lower $argv[1])

    switch $view_type
        case list icon column
            set -q argv[2]; and set window_count $argv[2]

            set view 'set the current view of the front Finder window to '$view_type' view'
        case '*'
            set -q argv[1]; and set window_count $argv[1]
    end

    echo 'tell application "Finder"
  if ('$window_count' <= (count Finder windows)) then
    set the target of window '$window_count' to (POSIX file "'$PWD'") as string
  else
    open (POSIX file "'$PWD'") as string
  end if
 ' $view '
end tell' | osascript >/dev/null
end

function finder::pwd::get -a window
    set -q window; or set window 1

    echo 'tell application "Finder"
  if ('$window' <= (count Finder windows)) then
    get POSIX path of (target of window '$window' as alias)
  else
    get POSIX path of (desktop as alias)
  end if
end tell' | osascript
end

function finder::track
    switch $argv[1]
        case enable
            functions -q finder:::track
            or function finder:::track --on-variable PWD
                finder::pwd::update
            end
            finder::pwd::update
        case disable
            functions -e finder:::track
    end
end

function finder::clean
    set -l paths $argv
    set -q argv[1]; or set paths .

    for path in $paths
        test -d $path; or continue

        find path -type f -name '*.DS_Store' -ls -delete
    end
end

function finder::defaults::query -a key
    set -l value (defaults read com.apple.Finder $key 2>/dev/null)
    or return 1

    switch $value
        case 1
            true
        case '*'
            false
    end
end

function finder::defaults::set -a key value
    defaults write com.apple.Finder $key -bool $value
    and killall Finder
end

function finder::defaults -a key
    set -e argv[1]

    set -l action status
    set -q argv[1]; and set action (string lower $argv[1])

    switch $action
        case hide off no false
            finder::defaults::set $key true
        case show on yes true
            finder::defaults::set $key false
        case toggle
            if finder::defaults::query $key
                finder::defaults::set $key false
            else
                finder::defaults::set $key true
            end
        case status
            switch $key
                case AppleShowAllFiles
                    if finder::defaults::query $key
                        echo 'Hidden files are visible.'
                    else
                        echo 'Hidden files are hidden.'
                    end
                case CreateDesktop
                    if finder::defaults::query $key
                        echo 'Desktop icons are hidden.'
                    else
                        echo 'Desktop icons are visible.'
                    end
            end
    end
end

function finder::quarantine::run -a sql
    set -l databases ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV*
    set -l cmd sqlite3 -separator ' | '

    for db in $databases
        $cmd $db $sql
    end
end

function finder::quarantine -a verb
    if set -q verb
        set verb (string lower $verb)
    else
        set verb show
    end

    set -e argv[1]

    switch $verb
        case show
            finder::quarantine::run "
SELECT LSQuarantineAgentName, LSQuarantineDataURLString
  FROM LSQuarantineEvent
 WHERE LSQuarantineDataURLString != ''
 ORDER BY LSQuarantineAgentName, LSQuarantineDataURLString;"
        case clear
            finder::quarantine::run 'DELETE FROM LSQuarantineEvent;'
        case clean
            if not set -q argv[1]
                echo >&2 'finder quarantine clean requires at least one file parameter'
                return 1
            end

            for attr in com.apple.{metadata:{kMDItemDownloadedDate,kMDItemWhereFroms},quarantine}
                xattr -r -d $attr $argv
            end
        case '*'
            echo >&2 "finder quarantine: unknown command '"$verb"'. Use 'show', 'clear', or 'clean'."
            return 1
    end
end

function finder::selected
    echo '
  tell application "Finder" to set theSelection to selection
  set output to ""
  set itemCount to count theSelection
  repeat with itemIndex from 1 to itemCount
    if itemIndex is less than itemCount then set theDelimiter to "\n"
    if itemIndex is itemCount then set theDelimiter to ""
    set currentItem to (item itemIndex of theSelection as alias)
    set currentItem to POSIX path of currentItem
    set output to output & currentItem & theDelimiter
  end repeat' | osascript
end

function finder -a verb -d 'Manipulate the finder with the current shell'
    if set -q verb
        set verb (string lower $verb)
    else
        set verb none
    end
    set -e argv[1]

    switch $verb
        case track
            finder::track enable
        case untrack
            finder::track disable
        case list icon column
            finder::pwd::update $verb $argv
        case pwd
            finder::pwd::get $argv[1]
        case cd
            cd (finder::pwd::get $argv[1])
        case pushd
            pushd (finder::pwd::get $argv[1])
        case clean
            finder::clean $argv
        case hidden
            finder::defaults AppleShowAllFiles $argv
        case desktop-icons
            finder::defaults CreateDesktop $argv
        case quarantine
            finder::quarantine $argv
        case selected
            finder::selected
        case help
            finder:::help
        case ''
            echo >&2 'Error: no command provided'
            finder:::help >&2
            return 1
        case '*'
            echo >&2 'Error: unknown command '$verb
            finder:::help >&2
            return 1
    end
end
