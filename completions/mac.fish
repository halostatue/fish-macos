# @halostatue/fish-macos/completions/mac.fish:v7.0.1

complete --command mac --erase

complete --command mac --arguments airdrop \
    --exclusive --condition __fish_use_subcommand \
    --description 'Changes AirDrop settings'
complete --command mac --arguments airport \
    --exclusive --condition __fish_use_subcommand \
    --description 'Work with AirPort (WiFi) settings'
complete --command mac --arguments brightness \
    --exclusive --condition __fish_use_subcommand \
    --description 'Adjust the screen brightness level'
complete --command mac --arguments flushdns \
    --exclusive --condition __fish_use_subcommand \
    --description 'Flushes DNS'
complete --command mac --arguments font-smoothing \
    --exclusive --condition __fish_use_subcommand \
    --description 'Manages font smoothing settings'
complete --command mac --arguments lsclean \
    --exclusive --condition __fish_use_subcommand \
    --description 'Cleans LaunchServices to remove duplicate Open with... entries'
complete --command mac --arguments mail \
    --exclusive --condition __fish_use_subcommand \
    --description 'Manage various operations of Mail.app'
complete --command mac --arguments proxy-icon \
    --exclusive --condition __fish_use_subcommand \
    --description 'Manage proxy icon appearance delay'
complete --command mac --arguments transparency \
    --exclusive --condition __fish_use_subcommand \
    --description 'Manage UI transparency'
complete --command mac --arguments vol \
    --exclusive --condition __fish_use_subcommand \
    --description 'Changes Mac volume; accepts 0–100 volume percentage'

for subcommand in airdrop airport brightness flushdns font-smoothing lsclean mail proxy-icon transparency version vol
    complete --command mac --condition '__fish_seen_subcommand_from '$subcommand \
        --short-option h --long-option help --description 'Help for mac '$subcommand
end

complete --command mac --condition '__fish_seen_subcommand_from brightness' \
    --arguments up --description 'Increases screen brightness'
complete --command mac --condition '__fish_seen_subcommand_from brightness' \
    --arguments down --description 'Decreases screen brightness'

for subcommand in airdrop proxy-icon transparency
    complete --command mac --condition '__fish_seen_subcommand_from '$subcommand \
        --arguments on --description 'Enables '$subcommand
    complete --command mac --condition '__fish_seen_subcommand_from '$subcommand \
        --arguments off --description 'Disables '$subcommand
    complete --command mac --condition '__fish_seen_subcommand_from '$subcommand \
        --arguments toggle --description 'Toggles '$subcommand
    complete --command mac --condition '__fish_seen_subcommand_from '$subcommand \
        --arguments status --description 'Shows the status of '$subcommand
end


complete --command mac --condition '__fish_seen_subcommand_from 'airport \
    --arguments scan --description 'Shows available networks'
complete --command mac --condition '__fish_seen_subcommand_from 'airport \
    --arguments ssid --description 'Shows the SSID'
complete --command mac --condition '__fish_seen_subcommand_from 'airport \
    --arguments password --description 'Gets the current WiFi network password'


complete --command mac --condition '__fish_seen_subcommand_from 'font-smoothing \
    --arguments on --description 'Enables font smoothing; app IDs can be provided to limit control'
complete --command mac --condition '__fish_seen_subcommand_from 'font-smoothing \
    --arguments off --description 'Disables font smoothing; app IDs can be provided to limit control'

complete --command mac --condition '__fish_seen_subcommand_from 'mail \
    --arguments vacuum --description 'Vacuums the Mail.app envelope index'
complete --command mac --condition '__fish_seen_subcommand_from 'mail \
    --arguments attachments --description 'Sets Mail.app attachment handling' \
    --require-parameter --no-files
complete --command mac --condition '__fish_seen_subcommand_from 'attachments \
    --arguments inline \
    --description 'Sets Mail.app attachment handling so that they are inline to the message'
complete --command mac --condition '__fish_seen_subcommand_from 'attachments \
    --arguments icon \
    --description 'Sets Mail.app attachment handling so that they are icons on the message'

complete --command mac --condition '__fish_seen_subcommand_from 'version \
    --short-option s --long-option simple --description 'Simple mac version name'
complete --command mac --condition '__fish_seen_subcommand_from 'version \
    --short-option l --long-option lowercase --description 'Lowercase mac version name'
complete --command mac --condition '__fish_seen_subcommand_from 'version \
    --short-option f --long-option version --description 'Full version number'
complete --command mac --condition '__fish_seen_subcommand_from 'version \
    --short-option c --long-option comparable --description 'Simplified comparable version value'
complete --command mac --condition '__fish_seen_subcommand_from 'version \
    --short-option h --long-option help --description 'Help for mac 'version

complete --command mac --condition '__fish_seen_subcommand_from 'vol \
    --arguments mute --description 'Mutes volume'
complete --command mac --condition '__fish_seen_subcommand_from 'vol \
    --arguments unmute --description 'Unmutes volume'
complete --command mac --condition '__fish_seen_subcommand_from 'vol \
    --arguments show --description 'Shows the current volume'
complete --command mac --condition '__fish_seen_subcommand_from 'vol \
    --arguments 10 --description 'Sets the volume to 10%'
complete --command mac --condition '__fish_seen_subcommand_from 'vol \
    --arguments 20 --description 'Sets the volume to 20%'
complete --command mac --condition '__fish_seen_subcommand_from 'vol \
    --arguments 30 --description 'Sets the volume to 30%'
complete --command mac --condition '__fish_seen_subcommand_from 'vol \
    --arguments 40 --description 'Sets the volume to 40%'
complete --command mac --condition '__fish_seen_subcommand_from 'vol \
    --arguments 50 --description 'Sets the volume to 50%'
complete --command mac --condition '__fish_seen_subcommand_from 'vol \
    --arguments 60 --description 'Sets the volume to 60%'
complete --command mac --condition '__fish_seen_subcommand_from 'vol \
    --arguments 70 --description 'Sets the volume to 70%'
complete --command mac --condition '__fish_seen_subcommand_from 'vol \
    --arguments 80 --description 'Sets the volume to 80%'
complete --command mac --condition '__fish_seen_subcommand_from 'vol \
    --arguments 90 --description 'Sets the volume to 90%'
complete --command mac --condition '__fish_seen_subcommand_from 'vol \
    --arguments 100 --description 'Sets the volume to 100%'
