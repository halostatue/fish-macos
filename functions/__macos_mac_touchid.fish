# @halostatue/fish-macos/functions/__macos_mac_touchid.fish:v7.0.1

function __macos_mac_touchid
    argparse --name 'mac touchid' h/help q/quiet -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: mac touchid SUBSYSTEM [STATE]

Enables or disables Touch ID support. Requires administrative permissions
and executes with sudo.

Subsystems:
  sudo        Manages Touch ID support for sudo

States:
  off         Disables Touch ID.
  on          Enables Touch ID.
  [status]    Shows the status of Touch ID.
  toggle      Toggles the status of Touch ID.

Options:
  -h, --help               Show this help'
        return 0
    end

    set --function subsystem (string lower -- $argv[1])
    set --erase argv[1]

    if set --query _flag_quiet
        set --append argv --quiet
    end

    switch $subsystem
        case sudo
            __macos_mac_touchid_sudo $argv
        case '*'
            echo >&2 'mac touchid: unknown subsystem.'
            __macos_mac_touchid --help >&2
            return 1
    end
end
