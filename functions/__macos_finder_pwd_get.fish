function __macos_finder_pwd_get
    set --local window 1

    if set --query argv[1]
        set window 1
    end

    echo 'tell application "Finder"
  if ('$window' <= (count Finder windows)) then
    get POSIX path of (target of window '$window' as alias)
  else
    get POSIX path of (desktop as alias)
  end if
end tell' | osascript
end
