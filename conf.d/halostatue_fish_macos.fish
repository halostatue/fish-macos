function _halostatue_fish_macos_uninstall -e halostatue_fish_macos_uninstall
    set --local functions app finder has:app has_app mac manp note ql remind

    for cmd in $functions
        complete --erase --command $cmd
    end

    set --append functions (status function) \
        (functions --all | string match --entire --regex '^__macos_app_|^__macos_finder_|^__macos_mac_')

    functions --erase $functions
end
