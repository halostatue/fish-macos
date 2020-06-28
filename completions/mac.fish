complete -ec mac

complete -xc mac -n __fish_use_subcommand -a airdrop -d 'Changes AirDrop settings'
complete -c mac -n '__fish_seen_subcommand_from airdrop' on -d 'Turns AirDrop on'
complete -c mac -n '__fish_seen_subcommand_from airdrop' off -d 'Turns AirDrop off'

complete -xc mac -n __fish_use_subcommand -a airport -d 'Works with AirPort (WiFi) settings'
complete -c mac -n '__fish_seen_subcommand_from airport' scan -d 'Shows available networks'
complete -c mac -n '__fish_seen_subcommand_from airport' ssid -d 'Shows the SSID'
complete -c mac -n '__fish_seen_subcommand_from airport' history -d 'Shows the WiFi connection history'
complete -c mac -n '__fish_seen_subcommand_from airport' on -d 'Turns AirPort on'
complete -c mac -n '__fish_seen_subcommand_from airport' off -d 'Turns AirPort off'
complete -c mac -n '__fish_seen_subcommand_from airport' password -d 'Gets the current WiFi network password'

complete -xc mac -n __fish_use_subcommand -a flushdns -d 'Flushes DNS'
complete -xc mac -n __fish_use_subcommand -a lock-screen -d 'Locks the screen'
complete -xc mac -n __fish_use_subcommand -a lsclean -d 'Cleans LaunchServices to remove duplicate Open with... entries'

complete -xc mac -n __fish_use_subcommand -a vol -d 'Changes Mac volume; accepts 0–100 volume percentage'
complete -c mac -n '__fish_seen_subcommand_from vol' mute -d 'Mutes volume'
complete -c mac -n '__fish_seen_subcommand_from vol' unmute -d 'Unmutes volume'
complete -c mac -n '__fish_seen_subcommand_from vol' show -d 'Shows the current volume'
complete -c mac -n '__fish_seen_subcommand_from vol' 10 -d 'Sets the volume to 10%'
complete -c mac -n '__fish_seen_subcommand_from vol' 20 -d 'Sets the volume to 20%'
complete -c mac -n '__fish_seen_subcommand_from vol' 30 -d 'Sets the volume to 30%'
complete -c mac -n '__fish_seen_subcommand_from vol' 40 -d 'Sets the volume to 40%'
complete -c mac -n '__fish_seen_subcommand_from vol' 50 -d 'Sets the volume to 50%'
complete -c mac -n '__fish_seen_subcommand_from vol' 60 -d 'Sets the volume to 60%'
complete -c mac -n '__fish_seen_subcommand_from vol' 70 -d 'Sets the volume to 70%'
complete -c mac -n '__fish_seen_subcommand_from vol' 80 -d 'Sets the volume to 80%'
complete -c mac -n '__fish_seen_subcommand_from vol' 90 -d 'Sets the volume to 90%'
complete -c mac -n '__fish_seen_subcommand_from vol' 100 -d 'Sets the volume to 100%'
