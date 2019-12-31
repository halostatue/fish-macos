function manp -d 'View a manpage in Preview'
    if set -q argv[1]
        if command -sq ps2pdf
            man -t $argv | ps2pdf - - | open -f -a Preview
        else
            man -t $argv | open -f -a Preview
        end
    else
        man
    end
end
