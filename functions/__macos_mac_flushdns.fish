function __macos_mac_flushdns
    argparse --name 'mac flushdns' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: mac flushdns [options]

Flushes the DNS cache.

Options:
  -h, --help               Show this help'
        return 0
    end

    dscacheutil -flushcache
    and killall -HUP mDNSResponder
end
