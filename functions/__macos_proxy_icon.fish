function __macos_proxy_icon -a state
    switch $state
        case on
            defaults write -g NSToolbarTitleViewRolloverDelay -float 0
        case off
            defaults delete -g NSToolbarTitleViewRolloverDelay
        case '*'
            echo >&2 Unknown state "'$state'". Must be on or off.
            return 1
    end
end
