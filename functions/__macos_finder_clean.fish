function __macos_finder_clean
    set -l paths $argv
    set -q argv[1]; or set paths .

    for path in $paths
        test -d $path; or continue

        find path -type f -name '*.DS_Store' -ls -delete
    end
end
