# @halostatue/fish-macos/functions/__macos_mac_proxy_icon.fish:v7.0.1

function __macos_mac_proxy_icon
    argparse --name 'mac proxy-icon' h/help q/query -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: mac proxy-icon [options] STATE

Enables or disables the visibility of the proxy icon without delay. macOS
versions older than Monterey always show the proxy icon.

States:
  FLOAT      Sets the display of the proxy icon to FLOAT fractional seconds.
  off        Sets the display of the proxy icon to default.
  on         Sets the display of the proxy icon to 0 seconds.
  [status]   Shows the duration of the proxy icon display.
  toggle     Toggles the display of the proxy icon.

Options:
  -q, --query             When getting status, suppresses output.
  -h, --help              Show this help'
        return 0
    end

    set --function state (string lower -- $argv[1])
    set --erase argv[1]

    switch $state
        case status ''
            set --function value (__macos_mac_defaults_query -g NSToolbarTitleViewRolloverDelay 0.5)

            if set --query _flag_query
                test $value -eq 0
            else if test $value -eq 0
                printf "immediate (0 seconds)\n"
            else
                printf "%0.2f seconds\n" $value
            end

        case toggle
            if __macos_mac_proxy_icon --query status
                __macos_mac_proxy_icon off
            else
                __macos_mac_proxy_icon on
            end

        case on
            defaults write -g NSToolbarTitleViewRolloverDelay -float 0
            and killall Finder

        case off
            defaults delete -g NSToolbarTitleViewRolloverDelay
            and killall Finder

        case '*'
            if string match --regex '^\\d+$|^\\d*\.\\d+$' $state
                defaults write -g NSToolbarTitleViewRolloverDelay -float $state
                and killall Finder
            else
                echo >&2 'mac proxy-icon: Unknown state.'
                __macos_mac_proxy_icon --help >&2
                return 1
            end
    end
end
