# @halostatue/fish-macos/functions/__macos_mac_lsclean.fish:v7.0.1

function __macos_mac_lsclean
    argparse --name 'mac lsclean' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: mac lsclean [options]

Cleans the LaunchServices registration list.

Options:
  -h, --help               Show this help'
        return 0
    end

    /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
        -kill -r -domain local -domain system -domain user
    and killall Finder
end
