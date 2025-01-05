# @halostatue/fish-macos/functions/__macos_finder_pwd_get.fish:v6.0.1

function __macos_finder_pwd_get
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
