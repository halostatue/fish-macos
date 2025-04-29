# @halostatue/fish-macos/functions/__macos_finder_clean.fish:v7.0.1

function __macos_finder_clean
    argparse --name 'finder clean' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: finder clean [options] [path...]

Removes .DS_Store files from the paths provided, or the current path if
one is not provided.

Options:
  -h, --help              Show this help'
        return 0
    end

    if set --query argv[1]
        set --function paths $argv
    else
        set --function paths .
    end

    for path in $paths
        test -d $path
        or continue

        find $path -type f -name '*.DS_Store' -ls -delete
    end
end
