function has:app -d 'Returns true if the named application exists'
    # Suppress these flags being passed to __macos_app_find
    argparse a/all q/quiet -- $argv
    or return 1

    set --query _flag_quiet || echo >&2 has:app is deprecated, use has_app instead

    if not set --query argv[1]
        echo >&2 Usage: (status function) APPNAME...
        return 1
    end

    __macos_app_find --exact --quiet $argv
end
