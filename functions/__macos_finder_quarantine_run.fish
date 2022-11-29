function __macos_finder_quarantine_run -a sql
    set --local databases ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV*
    set --local cmd sqlite3 -separator ' | '

    for db in $databases
        $cmd $db $sql
    end
end
