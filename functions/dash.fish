function dash -d 'Look up documentation in Dash'
    if has:app Dash.app
        then
        open "dash://"(string escape --style=url -- $argv)
    else
        echo >&2 "Dash.app is not installed."
        return 1
    end
end
