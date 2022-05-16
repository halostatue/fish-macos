function __macos_finder_pwd_update
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
