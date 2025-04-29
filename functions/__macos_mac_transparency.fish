# @halostatue/fish-macos/functions/__macos_mac_transparency.fish:v7.0.1

function __macos_mac_transparency
    argparse --name 'mac transparency' h/help q/query -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: mac transparency [options] STATE

Enables or disables interface transparency by setting the universal
access "reduce transparency" setting.

States:
  off        Disables interface transparency
  on         Enables interface transparency
  [status]   Shows the status of interface transparency
  toggle     Toggles interface transparency

Options:
  -q, --query             When getting status, suppresses output.
  -h, --help              Show this help'
        return 0
    end

    set function state (string lower -- $argv[1])
    set --erase argv[1]

    switch $state
        case status ''
            set function value (__macos_mac_defaults_query com.apple.universalaccess reduceTransparency 0)

            if set --query _flag_query
                test $value -eq 0
            else
                if test $value -eq 0
                    echo on
                else
                    echo off
                end
            end

        case on
            defaults delete com.apple.universalaccess reduceTransparency

        case off
            defaults write com.apple.universalaccess reduceTransparency -bool true

        case toggle
            if __macos_mac_transparency status --query
                __macos_mac_transparency off
            else
                __macos_mac_transparency on
            end

        case '*'
            echo >&2 'mac transparency: unknown state'
            __macos_mac_transparency --help >&2
            return 1
    end
end
