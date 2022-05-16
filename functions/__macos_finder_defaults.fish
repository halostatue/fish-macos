function __macos_finder_defaults -a key
    set -e argv[1]

    set -l action status
    set -q argv[1]; and set action (string lower $argv[1])

    switch $action
        case hide off no false
            __macos_finder_defaults_set $key true
        case show on yes true
            __macos_finder_defaults_set $key false
        case toggle
            if __macos_finder_defaults_query $key
                __macos_finder_defaults_set $key false
            else
                __macos_finder_defaults_set $key true
            end
        case status
            switch $key
                case AppleShowAllFiles
                    if __macos_finder_defaults_query $key
                        echo 'Hidden files are visible.'
                    else
                        echo 'Hidden files are hidden.'
                    end
                case CreateDesktop
                    if __macos_finder_defaults_query $key
                        echo 'Desktop icons are hidden.'
                    else
                        echo 'Desktop icons are visible.'
                    end
            end
    end
end
