function __macos_transparency -a state
    switch $state
        case on
            defaults write com.apple.universalaccess reduceTransparency -bool false
        case off
            defaults write com.apple.universalaccess reduceTransparency -bool true
        case '*'
            echo >&2 Unknown state "'$state'". Must be on or off.
            return 1
    end
end
