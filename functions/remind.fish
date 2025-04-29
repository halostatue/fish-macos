# @halostatue/fish-macos/functions/remind.fish:v7.0.1

function remind --description 'Add a reminder to Reminders.app'
    is_mac 'mountain lion'
    or return 1

    has_app Reminders
    or return 1

    if set --query argv
        set --function text $argv
    else
        set --function text (cat - | sed -e 's/$/<br>/')
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
