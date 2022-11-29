function has:app -d 'Returns true if the named application exists'
    # Suppress these flags being passed to has:app.
    argparse a/all q/quiet -- $argv
    or return 1

    if not set --query argv[1]
        echo >&2 Usage: (status function) APPNAME...
        return 1
    end

    __macos_app_find --exact --quiet $argv
end
