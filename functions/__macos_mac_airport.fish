# @halostatue/fish-macos/functions/__macos_mac_airport.fish:v7.0.1

function __macos_mac_airport::ssid
    __macos_mac_airport::run -I | string replace --filter --regex '\s+SSID: (\S+)' '$1'
end

function __macos_mac_airport::run
    /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport \
        $argv
end

function __macos_mac_airport
    argparse --name 'mac airport' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: mac airport STATE
       mac airport SUBCOMMAND [SSID]

Performs various WiFi (AirPort) operations. If no state or subcommand is
provided, the scan subcommand will be run by default. Otherwise a state (off,
on, toggle) or a subcommand must be provided.

States:
  off               Disables the WiFi adapter.
  on                Enables the WiFi adapter.
  toggle            Toggles the status of the WiFi adapter.

Subcommands:
  password [SSID]   Shows the password of the current or specified SSID.
  scan              Scans for WiFi networks..
  ssid              Shows the current WiFi network SSID.
  status            Shows the status of the WiFi adapter.

Options:
  -h, --help               Show this help'
        return 0
    end

    set --function cmd (string lower -- $argv[1])
    set --erase argv[1]

    switch $cmd
        case scan ''
            printf "Scanning...\r"
            __macos_mac_airport::run -s
        case network ssid
            __macos_mac_airport::ssid
        case off
            networksetup -setairportpower en0 off
        case on
            networksetup -setairportpower en0 on
        case status
            networksetup -getairportpower en0 | string replace --regex '^[^:]+: ' '' | string lower
        case toggle
            if test (__macos_mac_airport status) == on
                __macos_mac_airport off
            else
                __macos_mac_airport on
            end
        case password
            set --local ssid
            if set --query argv[1]
                set ssid $argv[1]
            else
                set ssid (__macos_mac_airport::ssid)
            end

            security find-generic-password -D "AirPort network password" -l $ssid -gw
        case '*'
            echo >&2 'mac airport: Unknown command.'
            __macos_mac_airport --help >&2
            return 1
    end
end
