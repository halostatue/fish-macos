function _halostatue_fish_macos_uninstall -e halostatue_fish_macos_uninstall
    functions -e (functions -a | command awk '
        /_halostatue_fish_macos_|^app$|^app::|^finder$|^finder::|^mac$|^mac::/
    ')

    complete -ec app
    complete -ec finder
    complete -ec mac
end
