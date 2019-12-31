function _halostatue_fish_macos_uninstall -e halostatue_fish_macos_uninstall
    functions -e (functions -a | command awk '/_halostatue_fish_macos_/')
end
