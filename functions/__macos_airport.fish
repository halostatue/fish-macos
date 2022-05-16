function __macos_airport -a cmd
    set -e argv[1]

    switch $cmd
        case scan
            __macos_airport_run -s
        case ssid
            __macos_airport_ssid
        case history
            __macos_airport_history
        case on off
            networksetup -setairportpower en0 $cmd
        case password
            set -l ssid
            if set -q argv[1]
                set ssid $argv[1]
            else
                set ssid (__macos_airport_ssid)
            end

            security find-generic-password -D "AirPort network password" $ssid -gw
        case '*'
            echo >&2 Unknown command "'$cmd'".
            return 1
    end
end
