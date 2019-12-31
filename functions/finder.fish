# Based on bashfinder: https://github.com/NapoleonWils0n/bashfinder.git
# and my port to zsh.

function _halostatue_fish_mac_update_finder_with_pwd
    set -l window_count 1
    set -l view ''
    set -l view_type none
    set -q argv[1]
    and set -l view_type (string lower $argv[1])

    switch $view_type
        case list icon column
            set -q argv[2]
            and set window_count $argv[2]

            set view 'set the current view of the front Finder window to '$view_type' view'
        case '*'
            set -q argv[1]
            and set window_count $argv[1]
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

function _halostatue_fish_mac_get_frontmost_finder_path
    set -l window 1
    set -q argv[1]
    and set -l window $argv[1]

    echo 'tell application "Finder"
  if ('$window' <= (count Finder windows)) then
    get POSIX path of (target of window '$window' as alias)
  else
    get POSIX path of (desktop as alias)
  end if
end tell' | osascript
end

function finder -d 'Link the finder with the current shell'
    set -l verb none
    set -q argv[1]
    and set -l verb (string lower $argv[1])

    switch $verb
        case track
            functions -q _halostatue_fish_mac_track_finder
            or function _halostatue_fish_mac_track_finder --on-variable PWD
                _halostatue_fish_mac_update_finder_with_pwd
            end
            _halostatue_fish_mac_update_finder_with_pwd
        case untrack
            functions -e _halostatue_fish_mac_track_finder
        case list icon column
            _halostatue_fish_mac_update_finder_with_pwd $verb
        case pwd
            _halostatue_fish_mac_get_frontmost_finder_path $argv[2]
        case cd
            cd (_halostatue_fish_mac_get_frontmost_finder_path $argv[2])
        case pushd
            pushd (_halostatue_fish_mac_get_frontmost_finder_path $argv[2])
        case clean
            find . -type f -name '*.DS_Store' -ls -delete
        case hidden
            set -l arg $argv[2]
            test -z $arg
            and set arg 'none-provided'

            switch (string lower $arg)
                case yes true
                    set arg true
                case no false
                    set arg false
                case '*'
                    echo 2>&1 'Input value must be yes or no.'
                    return 1
            end

            # Show/hide hidden files in Finder
            defaults write com.apple.Finder AppleShowAllFiles -bool $arg
            and killall Finder /System/Library/CoreServices/Finder.app
        case show-hidden
            finder hidden yes
        case hide-hidden
            finder hidden no
        case selected
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
        case '*'
            echo >&2 'Usage: '(status function)' track|untrack|cd|pwd
       '(status function)' list|icon|column
       '(status function)' clean|show-hidden|hide-hidden|selected

    track         Makes the frontmost Finder window track with the current
                  directory.
    untrack       Removes Finder directory tracking.
    pwd           Display the current directory to the current Finder path.
    cd            Changes the current directory to the current Finder path.
    pushd         Pushes the current directory to the current Finder path.
    list          Changes the frontmost Finder window to the list view of the
                  current path.
    icon          Changes the frontmost Finder window to the icon view of the
                  current path.
    column        Changes the frontmost Finder window to the column view of the
                  current path.
    clean         Removes .DS_Store files from the current directory down.
    show-hidden   Shows hidden files in the Finder.
    hide-hidden   Hides hidden files in the Finder.
    selected      Print the selected files on the command-line.'
    end
end
