# @halostatue/fish-macos/functions/__macos_mac_airport_run.fish:v6.1.0

function __macos_mac_airport_run
    /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport \
        $argv
end
