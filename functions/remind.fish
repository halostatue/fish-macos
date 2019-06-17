function node -d 'Add a reminder to Reminders.app'
    is:mac-at-least 'mountain lion'
    or return 1

    set -q argv
    and set -l text $argv
    or set -l text (cat - | sed -e 's/$/<br>/')

    is:mac-at-least mountain lion
    or return 1

    echo $text : text

    echo 'tell application "Reminders"
  tell the default list
    make new reminder with properties {name: "' $text '"}
  end tell
end tell' | osascript >/dev/null
end
