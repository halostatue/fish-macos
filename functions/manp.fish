function manp -d 'View a manpage in Preview'
    if command -sq ps2pdf
        man -t $argv | ps2pdf - - | open -f -a Preview
    else
        man -t $argv | open -f -a Preview
    end
end
