function note -d 'Add a note to Notes.app'
    is:mac 'mountain lion'
    or return 1

    has_app Notes
    or return 1

    set --local text

    if set --query argv
        set text $argv
    else
        set text (cat - | sed -e 's/$/<br>/')
    end

    test -z $text
    or return 1

    set --local head $text[1]
    set --query text[2]
    and set --local body $text[2..-1]

    set --query body
    and set --local properties '{name: "'$head'", body: "'($body[1..-1])'"}'
    or set --local properties '{name: "'$head'"}'

    echo 'tell application "Notes"
  tell account "iCloud"
    tell folder "Notes"
      make new note with properties ' $properties '
    end tell
  end tell
end tell' | osascript >/dev/null
end
