complete --command finder --erase
complete --command finder --exclusive --condition __fish_use_subcommand \
    --arguments track --description 'Enables Finder PWD tracking'
complete --command finder --exclusive --condition __fish_use_subcommand \
    --arguments untrack --description 'Disables Finder PWD tracking'
complete --command finder --exclusive --condition __fish_use_subcommand \
    --arguments pwd --description 'Prints the path of the Finder window'
complete --command finder --exclusive --condition __fish_use_subcommand \
    --arguments cd --description 'Changes to the path of the Finder window'
complete --command finder --exclusive --condition __fish_use_subcommand \
    --arguments pushd --description 'Pushes to the path of the Finder window'
complete --command finder --exclusive --condition __fish_use_subcommand \
    --arguments update --description 'Updates the Finder to PWD'
complete --command finder --exclusive --condition __fish_use_subcommand \
    --arguments list --description 'Sets Finder to list view with PWD'
complete --command finder --exclusive --condition __fish_use_subcommand \
    --arguments icon --description 'Sets Finder to icon view with PWD'
complete --command finder --exclusive --condition __fish_use_subcommand \
    --arguments column --description 'Sets Finder to column view with PWD'
complete --command finder --exclusive --condition __fish_use_subcommand \
    --arguments hidden --description 'Shows or hides `hidden` files'
complete --command finder --exclusive --condition __fish_use_subcommand \
    --arguments desktop-icons --description 'Shows or hides desktop icons'
complete --command finder --exclusive --condition __fish_use_subcommand \
    --arguments clean --description 'Cleans .DS_Store files'
complete --command finder --exclusive --condition __fish_use_subcommand \
    --arguments quarantine --description 'Works with file quarantine data'
complete --command finder --exclusive --condition __fish_use_subcommand \
    --arguments selected --description 'Print Finder selected files'

for sub in hidden desktop-icons
    complete -c finder --condition "__fish_seen_subcommand_from $sub" \
        --arguments off --description "Turns $sub off"
    complete -c finder --condition "__fish_seen_subcommand_from $sub" \
        --arguments on --description "Turns $sub on"
    complete -c finder --condition "__fish_seen_subcommand_from $sub" \
        --arguments toggle --description "Toggles $sub"
    complete -c finder --condition "__fish_seen_subcommand_from $sub" \
        --arguments status --description "Shows the status of $sub"
end

complete -c finder --condition '__fish_seen_subcommand_from quarantine' \
    --arguments show --description 'Shows quarantine events'
complete -c finder --condition '__fish_seen_subcommand_from quarantine' \
    --arguments clear --description 'Clears all quarantine events'
complete -c finder --condition '__fish_seen_subcommand_from quarantine' \
    --arguments clean --description 'Removes quarantine attributes from files' \
    --require-parameter --force-files
