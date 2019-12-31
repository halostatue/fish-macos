function airdrop -a cmd -d 'Manage MacOS AirDrop configuration'
    switch $cmd
        case on
            sudo ifconfig awdl0 up
        case off
            sudo ifconfig awdl0 down
        case status
            ifconfig awdl0 | awk '/status:/ { print $2; }'
        case '*'
            echo 1>&2 Unknown command "'$cmd'".
            return 1
    end
end
