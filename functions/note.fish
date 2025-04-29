# @halostatue/fish-macos/functions/note.fish:v7.0.1

function note --description 'Add a note to Notes.app'
    is_mac 'mountain lion'
    or return 1

    has_app Notes
    or return 1

    if set --query argv
        set --function text $argv
    else
        set --function text (cat - | sed -e 's/$/<br>/')
    end

    test -z $text
    or return 1

    set --function head $text[1]

    if set --query text[2]
        set --function body $text[2..-1]
    end

    if set --query body
        set --function properties '{name: "'$head'", body: "'($body[1..-1])'"}'
    else
        set --function properties '{name: "'$head'"}'
    end

    echo 'tell application "Notes"
  tell account "iCloud"
    tell folder "Notes"
      make new note with properties ' $properties '
    end tell
  end tell
end tell' | osascript >/dev/null
end
