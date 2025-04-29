# @halostatue/fish-macos/completions/finder.fish:v7.0.1

complete --command finder --erase

complete --command finder --arguments track \
    --exclusive --condition __fish_use_subcommand \
    --description 'Enables Finder PWD tracking'
complete --command finder --arguments untrack \
    --exclusive --condition __fish_use_subcommand \
    --description 'Disables Finder PWD tracking'
complete --command finder --arguments pwd \
    --exclusive --condition __fish_use_subcommand \
    --description 'Prints the path of the Finder window'
complete --command finder --arguments cd \
    --exclusive --condition __fish_use_subcommand \
    --description 'Changes to the path of the Finder window'
complete --command finder --arguments pushd \
    --exclusive --condition __fish_use_subcommand \
    --description 'Pushes to the path of the Finder window'
complete --command finder --arguments update \
    --exclusive --condition __fish_use_subcommand \
    --description 'Updates the Finder to PWD'
complete --command finder --arguments list \
    --exclusive --condition __fish_use_subcommand \
    --description 'Sets Finder to list view with PWD'
complete --command finder --arguments icon \
    --exclusive --condition __fish_use_subcommand \
    --description 'Sets Finder to icon view with PWD'
complete --command finder --arguments column \
    --exclusive --condition __fish_use_subcommand \
    --description 'Sets Finder to column view with PWD'
complete --command finder --arguments hidden \
    --exclusive --condition __fish_use_subcommand \
    --description 'Shows or hides `hidden` files'
complete --command finder --arguments desktop-icons \
    --exclusive --condition __fish_use_subcommand \
    --description 'Shows or hides desktop icons'
complete --command finder --arguments clean \
    --exclusive --condition __fish_use_subcommand \
    --description 'Cleans .DS_Store files'
complete --command finder --arguments quarantine \
    --exclusive --condition __fish_use_subcommand \
    --description 'Works with file quarantine data'
complete --command finder --arguments selected \
    --exclusive --condition __fish_use_subcommand \
    --description 'Print Finder selected files'

for subcommand in cd clean column desktop-icons hidden icon list pushd pwd quarantine selected track untrack update
    complete --command finder --condition '__fish_seen_subcommand_from '$subcommand \
        --short-option h --long-option help --description 'Help for finder '$subcommand
end

for subcommand in hidden desktop-icons
    complete --command finder --condition '__fish_seen_subcommand_from '$subcommand \
        --arguments off --description 'Turns '$subcommand' off'
    complete --command finder --condition '__fish_seen_subcommand_from '$subcommand \
        --arguments on --description 'Turns '$subcommand' on'
    complete --command finder --condition '__fish_seen_subcommand_from '$subcommand \
        --arguments toggle --description 'Toggles '$subcommand
    complete --command finder --condition '__fish_seen_subcommand_from '$subcommand \
        --arguments status --description 'Shows the status of '$subcommand
end

complete --command finder --condition '__fish_seen_subcommand_from 'quarantine \
    --arguments show --description 'Shows quarantine events'
complete --command finder --condition '__fish_seen_subcommand_from 'quarantine \
    --arguments clear --description 'Clears all quarantine events'
complete --command finder --condition '__fish_seen_subcommand_from 'quarantine \
    --arguments clean --description 'Removes 'quarantine' attributes from files' \
    --require-parameter --force-files
