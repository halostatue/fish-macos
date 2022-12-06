function __macos_finder_quarantine
    argparse --name 'finder quarantine' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: finder [options] [SUBCOMMAND] [FILE...]

Manage quarantine events.

Subcommands:
  [show]          Shows quarantine events by agent and URL.
  clean FILE...   Removes quarantine attributes from the specified file(s).
                  At least one file is required.
  clear           Clears all quarantine events.

Options:
  -h, --help              Show this help'
        return 0
    end

    set --local verb (string lower -- $argv[1])
    set --erase argv[1]

    switch $verb
        case show ''
            __macos_finder_quarantine_run "
SELECT LSQuarantineAgentName, LSQuarantineDataURLString
  FROM LSQuarantineEvent
 WHERE LSQuarantineDataURLString != ''
 ORDER BY LSQuarantineAgentName, LSQuarantineDataURLString;"
        case clear
            __macos_finder_quarantine_run 'DELETE FROM LSQuarantineEvent;'
        case clean
            if not set --query argv[1]
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
