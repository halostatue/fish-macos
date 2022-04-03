complete --command app --erase

complete --command app --exclusive --condition __fish_use_subcommand \
    --arguments bundleid --description 'Show bundle IDs for macOS apps'
complete --command app --condition '__fish_seen_subcommand_from bundleid' \
    --short-option x --long-option exact --description 'Exact matches only'
complete --command app --condition '__fish_seen_subcommand_from bundleid' \
    --short-option h --long-option help --description 'Help for app bundleid'

complete --command app --exclusive --condition __fish_use_subcommand \
    --arguments find --description 'Find macOS apps by pattern'
complete --command app --condition '__fish_seen_subcommand_from find' \
    --short-option x --long-option exact --description 'Exact matches only'
complete --command app --condition '__fish_seen_subcommand_from find' \
    --short-option a --long-option all --description 'Show all matches'
complete --command app --condition '__fish_seen_subcommand_from find' \
    --short-option q --long-option quiet --description 'Quiet (show no ouptut)'
complete --command app --condition '__fish_seen_subcommand_from find' \
    --short-option h --long-option help --description 'Help for app find'

complete --command app --exclusive --condition __fish_use_subcommand \
    --arguments icon --description 'Extracts a MacOS app icon as a png file'
complete --command app --condition '__fish_seen_subcommand_from icon' \
    --short-option x --long-option exact --description 'Exact matches only'
complete --command app --condition '__fish_seen_subcommand_from icon' \
    --short-option o --long-option output --description 'Extracts to this file or directory' \
    --force-files
complete --command app --condition '__fish_seen_subcommand_from icon' \
    --short-option w --long-option width --description 'Uses this pixel width' \
    --no-files
complete --command app --condition '__fish_seen_subcommand_from icon' \
    --short-option h --long-option help --description 'Help for app icon'

complete --command app --exclusive --condition __fish_use_subcommand \
    --arguments quit --description 'Quit macOS apps by pattern'
complete --command app --condition '__fish_seen_subcommand_from quit' \
    --short-option x --long-option exact --description 'Exact matches only'
complete --command app --condition '__fish_seen_subcommand_from quit' \
    --short-option r --long-option restart --description 'Restarts after quit'
complete --command app --condition '__fish_seen_subcommand_from quit' \
    --short-option h --long-option help --description 'Help for app quit'
