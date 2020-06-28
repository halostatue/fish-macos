complete -ec finder
complete -xc finder -n __fish_use_subcommand -a track -d 'Enables Finder PWD tracking'
complete -xc finder -n __fish_use_subcommand -a untrack -d 'Disables Finder PWD tracking'
complete -xc finder -n __fish_use_subcommand -a pwd -d 'Prints the path of the Finder window'
complete -xc finder -n __fish_use_subcommand -a cd -d 'Changes to the path of the Finder window'
complete -xc finder -n __fish_use_subcommand -a pushd -d 'Pushes to the path of the Finder window'
complete -xc finder -n __fish_use_subcommand -a update -d 'Updates the Finder to PWD'
complete -xc finder -n __fish_use_subcommand -a list -d 'Sets Finder to list view with PWD'
complete -xc finder -n __fish_use_subcommand -a icon -d 'Sets Finder to icon view with PWD'
complete -xc finder -n __fish_use_subcommand -a column -d 'Sets Finder to column view with PWD'
complete -xc finder -n __fish_use_subcommand -a hidden -d 'Shows or hides `hidden` files'
complete -xc finder -n __fish_use_subcommand -a desktop-icons -d 'Shows or hides desktop icons'
complete -xc finder -n __fish_use_subcommand -a clean -d 'Cleans .DS_Store files'
complete -xc finder -n __fish_use_subcommand -a quarantine -d 'Works with file quarantine data'
complete -xc finder -n __fish_use_subcommand -a selected -d 'Print Finder selected files'

for sub in hidden desktop-icons
    complete -c finder -n "__fish_seen_subcommand_from $sub" -a off -d "Turns $sub off"
    complete -c finder -n "__fish_seen_subcommand_from $sub" -a on -d "Turns $sub on"
    complete -c finder -n "__fish_seen_subcommand_from $sub" -a toggle -d "Toggles $sub"
    complete -c finder -n "__fish_seen_subcommand_from $sub" -a status -d "Shows the status of $sub"
end

complete -c finder -n '__fish_seen_subcommand_from quarantine' -a show -d 'Shows quarantine events'
complete -c finder -n '__fish_seen_subcommand_from quarantine' -a clear -d 'Clears all quarantine events'
complete -c finder -n '__fish_seen_subcommand_from quarantine' \
    -a clean -d 'Removes quarantine attributes from files' -r -F
