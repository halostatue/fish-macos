# @halostatue/fish-macos/functions/__macos_finder_quarantine_run.fish:v6.0.1

function __macos_finder_quarantine_run
    set --query argv[1]
    or return 1

    set --function databases ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV*
    set --function cmd sqlite3 -separator ' | '

    for db in $databases
        $cmd $db $argv
    end
end
