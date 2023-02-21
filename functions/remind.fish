function remind -d 'Add a reminder to Reminders.app'
    is:mac 'mountain lion'
    or return 1

    has_app Reminders
    or return 1

    set --local text

    if set --query argv
        set text $argv
    else
        set text (cat - | sed -e 's/$/<br>/')
    end

    test -z $text
    and return 0

    echo $text : text

    echo 'tell application "Reminders"
  tell the default list
    make new reminder with properties {name: "'$text'"}
  end tell
end tell' | osascript >/dev/null
end
