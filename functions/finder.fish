# Based on bashfinder: https://github.com/NapoleonWils0n/bashfinder.git
# and my port to zsh.

function finder -a verb -d 'Manipulate the finder with the current shell'
    if set -q verb
        set verb (string lower $verb)
    else
        set verb none
    end
    set -e argv[1]

    switch $verb
        case track
            __macos_finder_track enable
        case untrack
            __macos_finder_track disable
        case list icon column
            __macos_finder_pwd_update $verb $argv
        case pwd
            __macos_finder_pwd_get $argv[1]
        case cd
            cd (__macos_finder_pwd_get $argv[1])
        case pushd
            pushd (__macos_finder_pwd_get $argv[1])
        case clean
            __macos_finder_clean $argv
        case hidden
            __macos_finder_defaults AppleShowAllFiles $argv
        case desktop-icons
            __macos_finder_defaults CreateDesktop $argv
        case quarantine
            __macos_finder_quarantine $argv
        case selected
            __macos_finder_selected
        case help
            __macos_finder_help
        case ''
            echo >&2 'Error: no command provided'
            __macos_finder_help >&2
            return 1
        case '*'
            echo >&2 'Error: unknown command '$verb
            __macos_finder_help >&2
            return 1
    end
end
