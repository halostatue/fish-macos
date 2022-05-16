function __macos_finder_quarantine -a verb
    if set -q verb
        set verb (string lower $verb)
    else
        set verb show
    end

    set -e argv[1]

    switch $verb
        case show
            __macos_finder_quarantine_run "
SELECT LSQuarantineAgentName, LSQuarantineDataURLString
  FROM LSQuarantineEvent
 WHERE LSQuarantineDataURLString != ''
 ORDER BY LSQuarantineAgentName, LSQuarantineDataURLString;"
        case clear
            __macos_finder_quarantine_run 'DELETE FROM LSQuarantineEvent;'
        case clean
            if not set -q argv[1]
                echo >&2 'finder quarantine clean requires at least one file parameter'
                return 1
            end

            for attr in com.apple.{metadata:{kMDItemDownloadedDate,kMDItemWhereFroms},quarantine}
                xattr -r -d $attr $argv
            end
        case '*'
            echo >&2 "finder quarantine: unknown command '"$verb"'. Use 'show', 'clear', or 'clean'."
            return 1
    end
end
