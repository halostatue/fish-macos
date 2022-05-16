function __macos_finder_selected
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
