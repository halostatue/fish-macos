# @halostatue/fish-macos/functions/__macos_finder_desktop_icons.fish:v7.0.1

function __macos_finder_desktop_icons
    argparse --name 'finder desktop-icons' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: finder desktop-icons [options] STATE

Shows or hides the desktop icons. If not specified, shows the current state.

States:
  off        Hides the desktop icons
  on         Shows the desktop icons
  [status]   Shows desktop icon visibility
  toggle     Toggles desktop icon visibility

Options:
  -h, --help              Show this help'
        return 0
    end

    set --function action (string lower -- $argv[1])
    set --function key CreateDesktop

    switch $action
        case off
            __macos_finder_defaults::set $key false
        case on
            __macos_finder_defaults::set $key true
        case toggle
            if test (__macos_mac_defaults_query com.apple.Finder $key 1) -eq 1
                __macos_finder_defaults::set $key false
            else
                __macos_finder_defaults::set $key true
            end
        case status ''
            if test (__macos_mac_defaults_query com.apple.Finder $key 1) -eq 1
                echo 'Desktop icons are hidden.'
            else
                echo 'Desktop icons are visible.'
            end
    end
end
