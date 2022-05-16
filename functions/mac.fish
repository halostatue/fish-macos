function mac -a subcommand -d 'Manage several macOS functions'
    set -e argv[1]

    switch (string lower $subcommand)
        case airdrop
            __macos_airdrop $argv
        case airport
            __macos_airport $argv
        case flushdns
            __macos_flushdns $argv
        case lock-screen
            __macos_lock_screen $argv
        case lsclean
            __macos_lsclean $argv
        case vol
            __macos_vol $argv
        case '*'
            echo >&2 'mac: Unknown command.'
            return 1
    end
end
