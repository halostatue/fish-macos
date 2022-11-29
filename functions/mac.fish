function mac -a subcommand -d 'Manage several macOS functions'
    argparse --stop-nonopt h/help -- $argv

    if set --query _flag_help
        echo 'Usage: mac [options] subcommand [arguments...]

Manage several macOS functions.

Subcommands:
  airdrop         Manages AirDrop.
  airport         Performs various WiFi (AirPort) operations
  flushdns        Flushes the DNS cache
  font-smoothing  Enables or disables font smoothing
  lsclean         Cleans the LaunchServices registration list
  mail            Speed up Mail.app by vacuuming the envelope index
  proxy-icon      Enables or disables proxy icon delay
  transparency    Enables or disables interface transparency
  version         Shows the current macOS version
  vol             Controls the volume level

Options:
  -h, --help               Show this help'
        return 0
    end

    set --erase argv[1]

    switch (string lower $subcommand)
        case airdrop
            __macos_mac_airdrop $argv
        case airport
            __macos_mac_airport $argv
        case flushdns
            __macos_mac_flushdns $argv
        case font-smoothing
            __macos_mac_font_smoothing $argv
        case lsclean
            __macos_mac_lsclean $argv
        case mail
            __macos_mac_mail $argv
        case proxy-icon
            __macos_mac_proxy_icon $argv
        case transparency
            __macos_mac_transparency $argv
        case vol
            __macos_mac_vol $argv
        case version
            __macos_mac_version $argv
        case ''
            echo >&2 'mac: No command provided.'
            mac --help >&2
            return 1
        case '*'
            echo >&2 'mac: Unknown command.'
            mac --help >&2
            return 1
    end
end
