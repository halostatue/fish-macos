# @halostatue/fish-macos/completions/app.fish:v7.0.1

complete --command app --erase

complete --command app --arguments bundleid \
    --exclusive --condition __fish_use_subcommand \
    --description 'Show bundle IDs for macOS apps'

complete --command app --arguments find \
    --exclusive --condition __fish_use_subcommand \
    --description 'Find macOS apps by pattern'

complete --command app --arguments frontmost \
    --exclusive --condition __fish_use_subcommand \
    --description 'Shows the front-most application'

complete --command app --arguments icon \
    --exclusive --condition __fish_use_subcommand \
    --description 'Extracts a MacOS app icon as a png file'

complete --command app --arguments quit \
    --exclusive --condition __fish_use_subcommand \
    --description 'Quit macOS apps by pattern'

for subcommand in bundleid find
    complete --command app --condition '__fish_seen_subcommand_from '$subcommand \
        --short-option x --long-option exact --description 'Exact matches only'

    complete --command app --condition '__fish_seen_subcommand_from '$subcommand \
        --short-option a --long-option all --description 'Show all matches'

    complete --command app --condition '__fish_seen_subcommand_from '$subcommand \
        --short-option q --long-option quiet --description 'Quiet (show no output)'

    complete --command app --condition '__fish_seen_subcommand_from '$subcommand \
        --short-option h --long-option help --description 'Help for app '$subcommand
end

complete --command app --condition '__fish_seen_subcommand_from 'bundleid \
    --short-option s --long-option short --description 'Show only the bundle ID'

complete --command app --condition '__fish_seen_subcommand_from 'frontmost \
    --short-option b --long-option bundle-id --description 'Shows the app bundle ID'
complete --command app --condition '__fish_seen_subcommand_from 'frontmost \
    --short-option p --long-option path --description 'Shows the app path'
complete --command app --condition '__fish_seen_subcommand_from 'frontmost \
    --short-option n --long-option name --description 'Shows the app name'
complete --command app --condition '__fish_seen_subcommand_from 'frontmost \
    --short-option P --long-option pid --description 'Shows the PID of the app'
complete --command app --condition '__fish_seen_subcommand_from 'frontmost \
    --short-option a --long-option all --description 'Shows all details'
complete --command app --condition '__fish_seen_subcommand_from 'frontmost \
    --short-option h --long-option help --description 'Help for app 'frontmost

complete --command app --condition '__fish_seen_subcommand_from 'icon \
    --short-option x --long-option exact --description 'Exact matches only'
complete --command app --condition '__fish_seen_subcommand_from 'icon \
    --short-option o --long-option output --description 'Extracts to this file or directory' \
    --force-files
complete --command app --condition '__fish_seen_subcommand_from 'icon \
    --short-option w --long-option width --description 'Uses this pixel width' \
    --no-files
complete --command app --condition '__fish_seen_subcommand_from 'icon \
    --short-option h --long-option help --description 'Help for app 'icon

complete --command app --condition '__fish_seen_subcommand_from 'quit \
    --short-option x --long-option exact --description 'Exact matches only'
complete --command app --condition '__fish_seen_subcommand_from 'quit \
    --short-option r --long-option restart --description 'Restart after quit'
complete --command app --condition '__fish_seen_subcommand_from 'quit \
    --short-option h --long-option help --description 'Help for app 'quit
