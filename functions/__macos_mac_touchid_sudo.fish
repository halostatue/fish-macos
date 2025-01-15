# @halostatue/fish-macos/functions/__macos_mac_touchid_sudo.fish:v6.1.0

function __macos_mac_touchid_sudo::print_status
    set --query _flag_quiet
    or printf "%-12s: %s\n" $argv
end

function __macos_mac_touchid_sudo::remove_one
    path is --type file --perm read
    and grep $argv[1] $argv[2]
    and sudo sed -i '' -e "/$argv[1]/d" $argv[2]
end

function __macos_mac_touchid_sudo::clean_macports_reattach
    # Check for MacPorts pam_reattach to disable it in this version.
    set --function files (path filter --type file --perm read /etc/pam.d/sudo_local /etc/pam.d/sudo)

    if grep -q /opt/local/lib/pam/pam_reattach.so $files
        echo >&2 "MacPorts pam_reattach detected. Removing for system safety."
        echo >&2 "  Use a Homebrew or other installation that does not require"
        echo >&2 "  sudo to install pam_reattach so that your system is not"
        echo >&2 "  unusable if pam_reattach is missing or otherwise broken."

        for file in $files
            __macos_mac_touchid_sudo::remove_one pam_reattach $file
        end
    end
end

function __macos_mac_touchid_sudo::remove
    osascript -e 'tell application "System Preferences" to quit'
    for file in /etc/pam.d/sudo_local /etc/pam.d/sudo
        for ext in pam_reattach pam_tid
            __macos_mac_touchid_sudo::remove_one {$ext} $file
            and __macos_mac_touchid_sudo::print_status $ext disabled
        end
    end

    if ! test -s /etc/pam.d/sudo_local
        # If /etc/pam.d/sudo_local is empty, remove it.
        sudo rm -f /etc/pam.d/sudo_local
    end
end

function __macos_mac_touchid_sudo::add_local
    set --function s

    set --query argv[1]
    and set --function reattach $argv[1]

    # We *may* need to migrate from /etc/pam.d/sudo to /etc/pam.d/sudo_local
    for ext in pam_reattach pam_tid
        if grep -q $ext /etc/pam.d/sudo
            echo >&2 "Moving $ext from /etc/pam.d/sudo to /etc/pam.d/sudo_local"
            __macos_mac_touchid_sudo::remove_one $ext /etc/pam.d/sudo
        end
    end

    if test -s /etc/pam.d/sudo_local
        if ! grep -q pam_tid /etc/pam.d/sudo_local
            set s (printf "%-10s %-14s %s" auth sufficient pam_tid.so)

            if grep -q pam_reattach /etc/pam.d/sudo_local
                sudo sed -i '' \
                    -f (printf "/pam_reattach/a\\\%b%s\n" '\n' $s | psub) \
                    /etc/pam.d/sudo_local
            else
                sudo sed -i '' \
                    -f (printf "1i\\\%b%s\n" '\n' $s | psub) \
                    /etc/pam.d/sudo_local
            end
            and __macos_mac_touchid_sudo::print_status pam_tid enabled
        end

        test -z "$reattach"
        and return 0

        if ! grep -q $reattach /etc/pam.d/sudo_local
            if grep -q pam_reattach /etc/pam.d/sudo_local
                echo >&2 "WARNING: pam_reattach is not configured with $reattach."
                grep >&2 pam_reattach /etc/pam.d/sudo_local
                echo >&2 "Removing."

                __macos_mac_touchid_sudo::remove_one pam_reattach /etc/pam.d/sudo_local
            end
        end

        if ! grep -q pam_reattach /etc/pam.d/sudo
            set s (printf "%-10s %-14s %s" auth optional $reattach)

            sudo sed -i '' \
                -f (printf "/pam_tid\\.so/i\\\%b%s" '\n' $s | psub) \
                /etc/pam.d/sudo
            and __macos_mac_touchid_sudo::print_status pam_reattach enabled
        end
    else
        set fish_trace 1
        sudo touch /etc/pam.d/sudo_local

        test -n "$reattach"
        and printf "%-10s %-14s %s" auth optional $reattach |
            sudo tee /etc/pam.d/sudo_local >/dev/null
        and __macos_mac_touchid_sudo::print_status pam_reattach enabled

        printf "%-10s %-14s %s" auth sufficient pam_tid.so |
            sudo tee /etc/pam.d/sudo_local >/dev/null
        and __macos_mac_touchid_sudo::print_status pam_tid enabled
    end
end

function __macos_mac_touchid_sudo::add
    osascript -e 'tell application "System Preferences" to quit'
    __macos_mac_touchid_sudo::clean_macports_reattach

    set --query argv[1]
    and set --function reattach $argv[1]

    if path is --perm read --type file /etc/pam.d/sudo_local{,.template}
        __macos_mac_touchid_sudo::add_local $reattach
    else
        set --function s

        if ! grep -q 'pam_tid\.so' /etc/pam.d/sudo
            set s (printf "%-10s %-14s %s" auth sufficient pam_tid.so)

            sudo sed -i '' \
                -f (printf "/^# sudo: auth account password session/a\\\%b%s\n" '\n' $s | psub) \
                /etc/pam.d/sudo
            and __macos_mac_touchid_sudo::print_status pam_tid enabled
        end

        test -z "$reattach"
        and return 0

        if ! grep -q $reattach /etc/pam.d/sudo && grep -q pam_reattach /etc/pam.d/sudo
            echo >&2 "WARNING: pam_reattach is not configured with $reattach."
            grep >&2 pam_reattach /etc/pam.d/sudo
            echo >&2 "Removing."

            __macos_mac_touchid_sudo::remove_one pam_reattach /etc/pam.d/sudo
        end

        if ! grep -q pam_reattach /etc/pam.d/sudo
            set s (printf "%-10s %-14s %s" auth optional $reattach)

            sudo sed -i '' \
                -f (printf "/pam_tid\\.so/i\\\%b%s" '\n' $s | psub) \
                /etc/pam.d/sudo
            and __macos_mac_touchid_sudo::print_status pam_reattach enabled
        end
    end
end

function __macos_mac_touchid_sudo
    argparse --name 'mac touchid sudo' h/help q/quiet -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: mac touchid sudo [STATE]

Enables or disables Touch ID support for sudo. Requires administrative
permissions to edit /etc/pam.d/sudo_local and executes with sudo.

If pam_reattach is installed, this will be managed as well. Note that if
pam_reattach is installed using sudo, it is imperative that Touch ID
support be disabled first or you may be in a situation where you cannot
use sudo. Note that MacPorts-installed pam_reattach will never be used.

States:
  off         Disables Touch ID.
  on          Enables Touch ID.
  [status]    Shows the status of Touch ID.
  toggle      Toggles the status of Touch ID.

Options:
  -h, --help               Show this help'
        return 0
    end

    set --function subcommand (string lower -- $argv[1])
    set --erase argv[1]

    switch $subcommand
        case on
            for d in /opt/homebrew /usr/local /usr
                for f in $d/lib/pam/pam_reattach.so*
                    if test -f $f
                        set --function reattach (string replace --all --regex / \\/ $f)
                        break
                    end
                end
            end

            __macos_mac_touchid_sudo::add $reattach

        case off
            __macos_mac_touchid_sudo::remove

        case status ''
            set --function files (path filter --type file --perm read /etc/pam.d/sudo_local /etc/pam.d/sudo)

            set --function pam_tid disabled
            set --function pam_reattach disabled

            grep -q pam_tid.so $files && set pam_tid enabled
            grep -q pam_reattach.so $files && set pam_reattach enabled

            if set --query _flag_quiet
                test $pam_tid = enabled
            else

                __macos_mac_touchid_sudo::print_status pam_tid $pam_tid
                __macos_mac_touchid_sudo::print_status pam_reattach $pam_reattach
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
