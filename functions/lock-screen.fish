function lock-screen -d 'Lock the screen'
    /System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession \
        -suspend $argv
end
