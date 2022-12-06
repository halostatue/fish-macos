function __macos_finder_hidden
    argparse --name 'finder hidden' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: finder hidden [options] STATE

Shows or hides files that are normally hidden from the Finder. If not
specified, shows the current state.

States:
  off        Hides files that are normally hidden from the Finder
  on         Shows files that are normally hidden from the Finder
  [status]   Shows the status of the hidden files setting
  toggle     Toggles the hidden files setting

Options:
  -h, --help              Show this help'
        return 0
    end

    set --local action (string lower -- $argv[1])
    set --local key AppleShowAllFiles

    switch $action
        case off
            __macos_finder_defaults_set $key false
        case on
            __macos_finder_defaults_set $key true
        case toggle
            if test (__macos_mac_defaults_query com.apple.Finder $key 0) -eq 1
                __macos_finder_defaults_set $key false
            else
                __macos_finder_defaults_set $key true
            end
        case status ''
            if test (__macos_mac_defaults_query com.apple.Finder $key 0) -eq 1
                echo 'Hidden files are visible in finder.'
            else
                echo 'Hidden files are hidden in finder.'
            end
    end
end
