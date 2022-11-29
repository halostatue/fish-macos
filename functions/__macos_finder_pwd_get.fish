function __macos_finder_pwd_get -a window
    set --query window; or set window 1

    echo 'tell application "Finder"
  if ('$window' <= (count Finder windows)) then
    get POSIX path of (target of window '$window' as alias)
  else
    get POSIX path of (desktop as alias)
  end if
end tell' | osascript
end
