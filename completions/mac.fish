complete --command mac --erase

complete --command mac --exclusive --condition __fish_use_subcommand \
    --arguments airdrop --description 'Changes AirDrop settings'
complete --command mac --condition '__fish_seen_subcommand_from airdrop' \
    --arguments on --description 'Turns AirDrop on'
complete --command mac --condition '__fish_seen_subcommand_from airdrop' \
    --arguments off --description 'Turns AirDrop off'

complete --command mac --exclusive --condition __fish_use_subcommand \
    --arguments airport --description 'Works with AirPort (WiFi) settings'
complete --command mac --condition '__fish_seen_subcommand_from airport' \
    --arguments scan --description 'Shows available networks'
complete --command mac --condition '__fish_seen_subcommand_from airport' \
    --arguments ssid --description 'Shows the SSID'
complete --command mac --condition '__fish_seen_subcommand_from airport' \
    --arguments history --description 'Shows the WiFi connection history'
complete --command mac --condition '__fish_seen_subcommand_from airport' \
    --arguments on --description 'Turns AirPort on'
complete --command mac --condition '__fish_seen_subcommand_from airport' \
    --arguments off --description 'Turns AirPort off'
complete --command mac --condition '__fish_seen_subcommand_from airport' \
    --arguments password --description 'Gets the current WiFi network password'

complete --command mac --exclusive --condition __fish_use_subcommand \
    --arguments flushdns --description 'Flushes DNS'
complete --command mac --exclusive --condition __fish_use_subcommand \
    --arguments lock-screen --description 'Locks the screen'
complete --command mac --exclusive --condition __fish_use_subcommand \
    --arguments lsclean --description 'Cleans LaunchServices to remove duplicate Open with... entries'

complete --command mac --exclusive --condition __fish_use_subcommand \
    --arguments vol --description 'Changes Mac volume; accepts 0–100 volume percentage'
complete --command mac --condition '__fish_seen_subcommand_from vol' \
    --arguments mute --description 'Mutes volume'
complete --command mac --condition '__fish_seen_subcommand_from vol' \
    --arguments unmute --description 'Unmutes volume'
complete --command mac --condition '__fish_seen_subcommand_from vol' \
    --arguments show --description 'Shows the current volume'
complete --command mac --condition '__fish_seen_subcommand_from vol' \
    --arguments 10 --description 'Sets the volume to 10%'
complete --command mac --condition '__fish_seen_subcommand_from vol' \
    --arguments 20 --description 'Sets the volume to 20%'
complete --command mac --condition '__fish_seen_subcommand_from vol' \
    --arguments 30 --description 'Sets the volume to 30%'
complete --command mac --condition '__fish_seen_subcommand_from vol' \
    --arguments 40 --description 'Sets the volume to 40%'
complete --command mac --condition '__fish_seen_subcommand_from vol' \
    --arguments 50 --description 'Sets the volume to 50%'
complete --command mac --condition '__fish_seen_subcommand_from vol' \
    --arguments 60 --description 'Sets the volume to 60%'
complete --command mac --condition '__fish_seen_subcommand_from vol' \
    --arguments 70 --description 'Sets the volume to 70%'
complete --command mac --condition '__fish_seen_subcommand_from vol' \
    --arguments 80 --description 'Sets the volume to 80%'
complete --command mac --condition '__fish_seen_subcommand_from vol' \
    --arguments 90 --description 'Sets the volume to 90%'
complete --command mac --condition '__fish_seen_subcommand_from vol' \
    --arguments 100 --description 'Sets the volume to 100%'
