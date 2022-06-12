function note -d 'Add a note to Notes.app'
    is:mac 'mountain lion'
    or return 1

    has:app Notes
    or return 1

    set -l text

    if set -q argv
        set text $argv
    else
        set text (cat - | sed -e 's/$/<br>/')
    end

    test -z $text
    or return 1

    set -l head $text[1]
    set -q text[2]
    and set -l body $text[2..-1]

    set -q body
    and set -l properties '{name: "'$head'", body: "'($body[1..-1])'"}'
    or set -l properties '{name: "'$head'"}'

    echo 'tell application "Notes"
  tell account "iCloud"
    tell folder "Notes"
      make new note with properties ' $properties '
    end tell
  end tell
end tell' | osascript >/dev/null
end
