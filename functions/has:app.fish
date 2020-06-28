function has:app -d 'Returns true if the named application exists'
    # Suppress these flags being passed to has:app.
    argparse -x a,A 'a/any' 'A/all' 'q/quiet' -- $argv

    set -q argv[1]
    or begin
        echo >&2 Usage: (status function) APPNAME...
        return 1
    end

    app find --any --quiet $argv
end
