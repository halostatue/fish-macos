# @halostatue/fish-macos/functions/__macos_mac_touchid_sudo.fish:v7.0.1

# Massively simplified. This version _only_ works if /etc/pam.d/sudo includes `auth
# include sudo_local` and requires manual removal of `pam_reattach` and `pam_tid` from
# `/etc/pam.d/sudo` _manually_ if present.

function __macos_mac_touchid_sudo::check_supported
    if string match -rq '^\s*auth\s+include\s+sudo_local$' </etc/pam.d/sudo
        return 0
    end

    echo "Unsupported sudo configuration, cannot find 'auth include sudo_local'. \
      If your macOS installation supports 'include', add this at the top:" |
        fmt -s >&2
    printf >&2 "\n  auth       include        sudo_local\n\n"
    printf >&2 "Once this has been added, try again.\n"

    return 1
end

function __macos_mac_touchid_sudo::check_old_install
    set --function found

    string match -rq '^\s*auth\s+sufficient\s+pam_tid\.so' </etc/pam.d/sudo
    and set --append found pam_tid

    string match -rq '^\s*auth\s+optional\s+.+pam_reattach\.so' </etc/pam.d/sudo
    and set --append found pam_reattach

    if set --query found[1]
        set found (string join ' and ' $found)
        printf >&2 "Sudo support for "$found" present in /etc/pam.d/sudo.\n\n"
        echo "This is unsupported by 'mac touchid sudo' and must be manually \
          removed before continuing." | fmt -s >&2

        return 0
    end

    return 1
end

function __macos_mac_touchid_sudo::print_status
    set --query _flag_quiet
    or printf "%-15s: %s\n" $argv
end

function __macos_mac_touchid_sudo::remove_one
    path is --type file --perm read /etc/pam.d/sudo_local
    and grep -q $argv[1] /etc/pam.d/sudo_local
    and sudo sed -i '' -e "/$argv[1]/d" /etc/pam.d/sudo_local
end

function __macos_mac_touchid_sudo::remove
    osascript -e 'tell application "System Preferences" to quit'

    for ext in pam_tid pam_reattach
        __macos_mac_touchid_sudo::remove_one {$ext} /etc/pam.d/sudo_local
        and __macos_mac_touchid_sudo::print_status $ext disabled
    end

    if ! test -s /etc/pam.d/sudo_local
        # If /etc/pam.d/sudo_local is empty, remove it.
        sudo rm -f /etc/pam.d/sudo_local
    end
end

function __macos_mac_touchid_sudo::add
    set --function targets

    test -f /etc/pam.d/sudo_local
    or sudo touch /etc/pam.d/sudo_local

    if set --query argv[1]
        set --function reattach $argv[1]

        if string match -rq '^\s*auth\s+optional\s+'$argv[1] </etc/pam.d/sudo_local
            if string match -rq '^\s*auth\s+sufficient\s+pam_tid\.so' </etc/pam.d/sudo_local
                __macos_mac_touchid_sudo::print_status pam_reattach enabled
                __macos_mac_touchid_sudo::print_status pam_tid enabled

                return 0
            end
        end

        set --append targets pam_reattach pam_tid
    else if string match -rq '^\s*auth\s+sufficient\s+pam_tid\.so' </etc/pam.d/sudo_local
        __macos_mac_touchid_sudo::print_status pam_tid enabled
    else
        set --append targets pam_tid
    end

    osascript -e 'tell application "System Preferences" to quit'

    for target in $targets
        if grep -q $target /etc/pam.d/sudo_local
            __macos_mac_touchid_sudo::remove_one $target /etc/pam.d/sudo_local
        end
    end

    if set --query reattach
        printf "%-10s %-14s %s\n" \
            auth optional $reattach \
            auth sufficient pam_tid.so |
            sudo tee -a /etc/pam.d/sudo_local >/dev/null
        and begin
            __macos_mac_touchid_sudo::print_status pam_reattach enabled
            __macos_mac_touchid_sudo::print_status pam_tid enabled
        end
    else
        printf "%-10s %-14s %s\n" auth sufficient pam_tid.so |
            sudo tee -a /etc/pam.d/sudo_local >/dev/null
        and __macos_mac_touchid_sudo::print_status pam_tid enabled
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


    __macos_mac_touchid_sudo::check_supported
    or return

    __macos_mac_touchid_sudo::check_old_install
    and return

    set --function subcommand (string lower -- $argv[1])
    set --erase argv[1]

    switch $subcommand
        case on
            set --local reattach /opt/local /opt/homebrew /usr/local /usr
            set reattach (path filter --type file $reattach/lib/pam/pam_reattach.so)

            if set --query reattach[1]
                set reattach (string replace --all --regex / \\/ $reattach[1])
            end

            __macos_mac_touchid_sudo::add $reattach

        case off
            __macos_mac_touchid_sudo::remove

        case status ''
            set --local pam_tid disabled
            set --local pam_reattach disabled

            grep -q pam_tid.so /etc/pam.d/sudo_local
            and set pam_tid enabled

            grep -q pam_reattach.so /etc/pam.d/sudo_local
            and set pam_reattach enabled

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
