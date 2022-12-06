function __macos_finder_pwd_update
    argparse --exclusive column,list,icon column list icon -- $argv
    or return 1

    set --local window_count 1
    set --local view ''
    set --local view_type ''

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
