# @halostatue/fish-macos/functions/__macos_mac_flushdns.fish:v7.0.1

function __macos_mac_flushdns
    argparse --name 'mac flushdns' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: mac flushdns [options]

Flushes the DNS cache. Requires sudo.

Options:
  -h, --help               Show this help'
        return 0
    end

    sudo dscacheutil -flushcache
    and sudo killall -HUP mDNSResponder
end
