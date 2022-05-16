function _halostatue_fish_macos_uninstall -e halostatue_fish_macos_uninstall
    functions -e (
      functions -a |
      string match --entire --regex '_halostatue_fish_macos_|^app$|^__macos_|^finder$|^mac$'
    ) has:app manp note pdfmerge ql remind trash

    complete --erase --command app
    complete --erase --command finder
    complete --erase --command mac
    complete --erase --command manp
    complete --erase --command ql
end
