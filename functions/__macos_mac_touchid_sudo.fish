function __macos_mac_touchid_sudo
    argparse --name 'mac touchid sudo' h/help q/quiet -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: mac touchid sudo [STATE]

Enables or disables Touch ID support for sudo. Requires administrative
permissions to edit /etc/pam.d/sudo and executes with sudo.

If pam_reattach is installed, this will be managed as well. Note that if
pam_reattach is installed using sudo (such as with MacPorts), it is
imperative that Touch ID support be disabled first or you may be in
a situation where you cannot use sudo.

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
    for d in /opt/homebrew /usr/local /usr /opt/local
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
                    set --query _flag_quiet || printf "%s\n" "pam_tid:      enabled"
                end
            end

            if test -n $reattach && not grep -q pam_reattach /etc/pam.d/sudo

                if sudo sed -i '' -e '/pam_tid\.so/i\
auth       optional      '$reattach /etc/pam.d/sudo
                    set --query _flag_quiet || printf "%s\n" "pam_reattach: enabled"

                    if string match --quiet --regex /opt/local $reattach && command --query port
                        set --query _flag_quiet || printf "\n"
                        printf >&2 "%s\n%s\n%s\n" \
                            "WARNING: $reattach is installed with MacPorts." \
                            "         Remember to disable Touch ID before uninstalling it or your" \
                            "         system may be unusable until the next macOS update."
                    end
                end
            end

        case off
            osascript -e 'tell application "System Preferences" to quit'
            if grep -q pam_tid.so /etc/pam.d/sudo
                if sudo sed -i '' -e /pam_tid.so/d /etc/pam.d/sudo
                    set --query _flag_quiet || printf "%s\n" "pam_tid:      disabled"
                end
            end

            if grep -q pam_reattach.so /etc/pam.d/sudo
                if sudo sed -i '' -e /pam_reattach.so/d /etc/pam.d/sudo
                    set --query _flag_quiet || printf "%s\n" "pam_reattach: disabled"
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
                printf 'pam_tid:      %s\npam_reattach: %s\n' $pam_tid $pam_reattach
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
