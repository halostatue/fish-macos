function quarantine -d 'Show or clear quarantine events'
    set -l databases ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV*
    set -l action show

    set -q argv[1]
    and set action (string lower $argv[1])

    set -l cmd sqlite3 -separator ' | '

    switch $action
        case show
            for db in $databases
                $cmd $db "SELECT LSQuarantineAgentName, LSQuarantineDataURLString
                  FROM LSQuarantineEvent
                 WHERE LSQuarantineDataURLString != ''
                 ORDER BY LSQuarantineAgentName, LSQuarantineDataURLString;"
            end
        case clear
            for db in $databases
                $cmd $db 'DELETE FROM LSQuarantineEvent;'
            end
        case clean
          if not set -q argv[2]
            echo >&2 (status function): 'clean requires at least one file parameter'
            return 1
          end

          for attr in com.apple.{metadata:{kMDItemDownloadedDate,kMDItemWhereFroms},quarantine}
            xattr -r -d $attr $argv[2..-1]
          end
        case '*'
            echo >&2 (status function)": unknown command '"$argv[1]"'. Use 'show', 'clear', or 'clean'."
            return 1
    end
end
