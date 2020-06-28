complete -ec app

complete -xc app -n __fish_use_subcommand -a bundle -d 'Shows bundle IDs for MacOS apps'

complete -xc app -n __fish_use_subcommand -a find -d 'Finds MacOS apps by name'
complete -c app -n '__fish_seen_subcommand_from find' -s a -d 'Find any apps matching the name'
complete -c app -n '__fish_seen_subcommand_from find' -l any -d 'Find any apps matching the name'
complete -c app -n '__fish_seen_subcommand_from find' -s A -d 'Find all apps matching the name'
complete -c app -n '__fish_seen_subcommand_from find' -l all -d 'Find all apps matching the name'
complete -c app -n '__fish_seen_subcommand_from find' -s q -d 'Quiet (show no output)'
complete -c app -n '__fish_seen_subcommand_from find' -l quiet -d 'Quiet (show no output)'

complete -xc app -n __fish_use_subcommand -a icon -d 'Extracts a MacOS app icon as a png file'
complete -rc app -n '__fish_seen_subcommand_from icon' -s o -d 'Extracts the icon as this file or to this path'
complete -rc app -n '__fish_seen_subcommand_from icon' -l output -d 'Extracts the icon as this file or to this path'
complete -xc app -n '__fish_seen_subcommand_from icon' -s w -d 'Sets the icon pixel width'
complete -xc app -n '__fish_seen_subcommand_from icon' -l width -d 'Sets the icon pixel width'

complete -xc app -n __fish_use_subcommand -a quit -d 'Quits an application'
complete -c app -n '__fish_seen_subcommand_from quit' -s R -d 'Restarts the application'
complete -c app -n '__fish_seen_subcommand_from quit' -l restart -d 'Restarts the application'
