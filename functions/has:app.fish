function has:app -d 'Returns true if the named application exists'
    set -q argv[1]
    or begin
        echo >&2 Usage: (status function) APP...
        return 1
    end

    set -l n Applications
    set -l paths /$n ~/$n /$n/Xcode.app/Contents/$n
    set -l apps $argv[1] $argv[1].app

    for candidate in {$paths}{$apps}
        test -d $candidate
        or test -L $candidate
        and return 0
    end

    return 1
end
