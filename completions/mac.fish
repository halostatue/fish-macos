complete --command mac --erase

complete --command mac --exclusive --condition __fish_use_subcommand \
    --arguments airdrop --description 'Changes AirDrop settings'
complete --command mac --condition '__fish_seen_subcommand_from airdrop' \
    --arguments on --description 'Turns AirDrop on'
complete --command mac --condition '__fish_seen_subcommand_from airdrop' \
    --arguments off --description 'Turns AirDrop off'
complete --command mac --condition '__fish_seen_subcommand_from airdrop' \
    --arguments status --description 'Shows the status of airdrop'

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
    --arguments font-smoothing --description 'Manages font smoothing settings'
complete --command mac --condition '__fish_seen_subcommand_from font-smoothing' \
    --arguments on --description 'Enables font smoothing; app IDs can be provided to limit control'
complete --command mac --condition '__fish_seen_subcommand_from font-smoothing' \
    --arguments off --description 'Disables font smoothing; app IDs can be provided to limit control'

complete --command mac --exclusive --condition __fish_use_subcommand \
    --arguments lock-screen --description 'Locks the screen'

complete --command mac --exclusive --condition __fish_use_subcommand \
    --arguments lsclean --description 'Cleans LaunchServices to remove duplicate Open with... entries'

complete --command mac --exclusive --condition __fish_use_subcommand \
    --arguments mail --description 'Manage various operations of Mail.app'
complete --command mac --condition '__fish_seen_subcommand_from mail' \
    --arguments vacuum --description 'Vacuums the Mail.app envelope index'
complete --command mac --condition '__fish_seen_subcommand_from mail' \
    --arguments attachments --description 'Sets Mail.app attachment handling'
complete --command mac --condition '__fish_seen_subcommand_from attachments' \
    --arguments inline \
    --description 'Sets Mail.app attachment handling so that they are inline to the message'
complete --command mac --condition '__fish_seen_subcommand_from attachments' \
    --arguments icon \
    --description 'Sets Mail.app attachment handling so that they are icons on the message'

complete --command mac --exclusive --condition __fish_use_subcommand \
    --arguments proxy-icon --description 'Manage proxy icon appearance delay'
complete --command mac --condition '__fish_seen_subcommand_from proxy-icon' \
    --arguments on --description 'Proxy icons are always visible (older macOS default)'
complete --command mac --condition '__fish_seen_subcommand_from proxy-icon' \
    --arguments off --description 'Proxy icons are shown after a short delay'

complete --command mac --exclusive --condition __fish_use_subcommand \
    --arguments transparency --description 'Manage UI transparency'
complete --command mac --condition '__fish_seen_subcommand_from transparency' \
    --arguments on --description 'Sets normal macOS transparency'
complete --command mac --condition '__fish_seen_subcommand_from transparency' \
    --arguments off --description 'Sets reduced macOS transparency'

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
