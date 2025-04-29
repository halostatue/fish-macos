# @halostatue/fish-macos/functions/__macos_finder_track.fish:v7.0.1

function __macos_finder_track
    argparse --name 'finder track' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: finder track [options]

Makes the first Finder window track with the shell PWD. This should be used
in a single shell instance only, and updates only when the PWD value is
updated.

Options:
  -h, --help              Show this help'
        return 0
    end

    if not functions --query __macos_finder_tracking
        function __macos_finder_tracking --on-variable PWD
            __macos_finder_pwd::update
        end
    end

    __macos_finder_pwd::update
end
