function __airport
    /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport \
        $argv
end

function __airport_ssid
    __airport -I | awk '/ SSID/ { print $2; }'
end

function airport -a cmd -d 'Manage MacOS airport configuration'
    switch $cmd
        case scan
            __airport -s
        case ssid
            __airport_ssid
        case history
            defaults read \
                /Library/Preferences/SystemConfiguration/com.apple.airport.preferences |
            grep LastConnected -A 7
        case on off
            networksetup -setairportpower en0 $cmd
        case password
            set -l ssid $argv[2]
            test -z $ssid
            and set -l $ssid (__airport_ssid)

            security find-generic-password -D "AirPort network password" $ssid -gw
    end
end
