function __macos_finder_quarantine_run -a sql
    set -l databases ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV*
    set -l cmd sqlite3 -separator ' | '

    for db in $databases
        $cmd $db $sql
    end
end
