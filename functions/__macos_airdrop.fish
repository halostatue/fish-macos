function __macos_airdrop -a subcommand
    switch (string lower $subcommand)
        case on
            sudo ifconfig awdl0 up
        case off
            sudo ifconfig awdl0 down
        case status
            ifconfig awdl0 | awk '/status:/ { print $2; }'
        case '*'
            echo >&2 Unknown command "'$cmd'".
            return 1
    end
end
