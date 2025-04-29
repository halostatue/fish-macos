# @halostatue/fish-macos/functions/__macos_mac_airdrop.fish:v7.0.1

function __macos_mac_airdrop
    argparse --name 'mac airdrop' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: mac airdrop STATE

Turns AirDrop on or off. Requires administrative permissions and
executes with sudo.

States:
  off         Disables AirDrop.
  on          Enables AirDrop.
  [status]    Shows the status of AirDrop.
  toggle      Toggles the status of AirDrop.

Options:
  -h, --help               Show this help'
        return 0
    end

    set --function subcommand (string lower -- $argv[1])
    set --erase argv[1]

    switch $subcommand
        case on
            sudo ifconfig awdl0 up
        case off
            sudo ifconfig awdl0 down
        case status ''
            ifconfig awdl0 | awk '/status:/ { print $2; }'
        case toggle
            if test (__macos_mac_airdrop status) == active
                __macos_mac_airdrop off
            else
                __macos_mac_airdrop on
            end
        case '*'
            echo >&2 'mac airdrop: unknown state.'
            __macos_mac_airdrop --help >&2
            return 1
    end
end
