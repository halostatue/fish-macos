function __macos_lock_screen
    /System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession \
        -suspend $argv
end
