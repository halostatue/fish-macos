function note -d 'Add a note to Notes.app'
    is:mac 'mountain lion'
    or return 1

    set -q argv
    and set -l text $argv
    or set -l text (cat - | sed -e 's/$/<br>/')

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
