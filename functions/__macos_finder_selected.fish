# @halostatue/fish-macos/functions/__macos_finder_selected.fish:v7.0.1

function __macos_finder_selected
    argparse --name 'finder selected' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: finder selected [options] [window#]

Print the selected files on the command-line.

Options:
  -h, --help              Show this help'
        return 0
    end

    echo '
  tell application "Finder" to set theSelection to selection
  set output to ""
  set itemCount to count theSelection
  repeat with itemIndex from 1 to itemCount
    if itemIndex is less than itemCount then set theDelimiter to "\n"
    if itemIndex is itemCount then set theDelimiter to ""
    set currentItem to (item itemIndex of theSelection as alias)
    set currentItem to POSIX path of currentItem
    set output to output & currentItem & theDelimiter
  end repeat' | osascript
end
