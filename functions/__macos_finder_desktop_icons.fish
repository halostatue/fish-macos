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

    set --local action $status
    set --local key CreateDesktop
    set --query argv[1]
    and set action (string lower $argv[1])

    switch $action
        case off
            __macos_finder_defaults_set $key true
        case on
            __macos_finder_defaults_set $key false
        case toggle
            if __macos_finder_defaults_query $key
                __macos_finder_defaults_set $key false
            else
                __macos_finder_defaults_set $key true
            end
        case status
            if __macos_finder_defaults_query $key
                echo 'Desktop icons are hidden.'
            else
                echo 'Desktop icons are visible.'
            end
    end
end
