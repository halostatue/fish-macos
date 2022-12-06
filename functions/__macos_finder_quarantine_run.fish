function __macos_finder_quarantine_run
    set --query argv[1]
    or return 1

    set --local databases ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV*
    set --local cmd sqlite3 -separator ' | '

    for db in $databases
        $cmd $db $argv
    end
end
