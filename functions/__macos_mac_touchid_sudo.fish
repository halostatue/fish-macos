function __macos_mac_touchid_sudo
    argparse --name 'mac touchid sudo' h/help q/quiet -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: mac touchid sudo [STATE]

Enables or disables Touch ID support for sudo. Requires administrative
permissions to edit /etc/pam.d/sudo and executes with sudo.

If pam_reattach.so is installed, this will be managed as well.

States:
  off         Disables Touch ID.
  on          Enables Touch ID.
  [status]    Shows the status of Touch ID.
  toggle      Toggles the status of Touch ID.

Options:
  -h, --help               Show this help'
        return 0
    end

    set --local subcommand (string lower -- $argv[1])
    set --erase argv[1]

    set --local reattach ''
    for d in /opt/homebrew /opt/homebrew /usr/local /usr
        for f in $d/lib/pam/pam_reattach.so*
            if test -f $f
                set reattach (string replace --all --regex / \\/ $f)
                break
            end
        end
    end


    switch $subcommand
        case on
            osascript -e 'tell application "System Preferences" to quit'
            if not grep -q pam_tid.so /etc/pam.d/sudo
                if sudo sed -i '' -e '/# sudo: auth account password session/a\
auth       sufficient     pam_tid.so' /etc/pam.d/sudo
                    set --query _flag_quiet || printf "pam_tid:      enabled\n"
                end
            end

            if test -n $reattach && not grep -q pam_reattach /etc/pam.d/sudo
                if sudo sed -i '' -e '/pam_tid\.so/i\
auth       optional      '$reattach /etc/pam.d/sudo
                    set --query _flag_quiet || printf "pam_reattach: enabled\n"
                end
            end

        case off
            osascript -e 'tell application "System Preferences" to quit'
            if grep -q pam_tid.so /etc/pam.d/sudo
                if sudo sed -i '' -e /pam_tid.so/d /etc/pam.d/sudo
                    set --query _flag_quiet || printf "pam_tid:      disabled\n"
                end
            end

            if grep -q pam_reattach.so /etc/pam.d/sudo
                if sudo sed -i '' -e /pam_reattach.so/d /etc/pam.d/sudo
                    set --query _flag_quiet || printf "pam_reattach: disabled\n"
                end
            end

        case status ''
            set --local pam_tid disabled
            set --local pam_reattach disabled

            grep -q pam_tid.so /etc/pam.d/sudo && set pam_tid enabled
            grep -q pam_reattach.so /etc/pam.d/sudo && set pam_reattach enabled

            if set --query _flag_quiet
                test $pam_tid = enabled
            else
                printf "pam_tid:      %s\npam_reattach: %s\n" $pam_tid $pam_reattach
            end

        case toggle
            if __macos_mac_touchid_sudo status --quiet
                __macos_mac_touchid_sudo off
            else
                __macos_mac_touchid_sudo on
            end

        case '*'
            echo >&2 'mac touchid: unknown state.'
            __macos_mac_touchid_sudo --help >&2
            return 1
    end
end
