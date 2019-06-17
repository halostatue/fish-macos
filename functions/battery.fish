function battery -d 'Report on MacOS battery status'
    set -q $argv[1]
    and set -l report $argv[1]
    or set -l report time

    switch (string lower $report)
        case life percent %
            pmset -g batt |
            command awk '/InternalBattery/ { print $3 }' |
            command sed 's/;//'
        case '*'
            pmset -g batt |
            command awk '/InternalBattery/ { print $4",", $5, $6 }' |
            command sed 's/;//'
    end
end
