function mac::airdrop -a subcommand -d 'Manage MacOS AirDrop configuration'
    switch (string lower $subcommand)
        case on up
            sudo ifconfig awdl0 up
        case off down
            sudo ifconfig awdl0 down
        case status
            ifconfig awdl0 | awk '/status:/ { print $2; }'
        case '*'
            echo >&2 Unknown command "'$cmd'".
            return 1
    end
end

function mac::airport::run
    /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport \
        $argv
end

function mac::airport::ssid
    mac::airport::run -I | awk '/ SSID/ { print $2; }'
end

function mac::airport::history
    defaults read \
        /Library/Preferences/SystemConfiguration/com.apple.airport.preferences | \
        awk '/LastConnected/,/SecurityType/ {
  nm = $1;
  $1 = $2 = "";
  gsub(/[";]/, "");
  gsub(/^\s+|\s+$/, "");

  if (nm == "LastConnected") {
    split($0, v);
    split(v[2], t, ":");

    ix = v[1] " " t[1] ":" t[2] " UTC";
    last_connected[ix] = ix;
  } else if (nm == "SSIDString") {
    ssid[ix] = $0;
  } else if (nm == "SecurityType") {
    security_type[ix] = $0;
  }
}

END {
  n = asort(last_connected);

  for (i = n; i > 0; i--) {
    ix = last_connected[i];
    print ix "\t" ssid[ix], "(" security_type[ix] ")";
  }
}'
end

function mac::airport -a cmd -d 'Manage MacOS airport configuration'
    set -e argv[1]

    switch $cmd
        case scan
            mac::airport::run -s
        case ssid
            mac::airport::ssid
        case history
            mac::airport::history
        case on off
            networksetup -setairportpower en0 $cmd
        case password
            set -l ssid
            if set -q argv[1]
                set ssid $argv[1]
            else
                set ssid (mac::airport::ssid)
            end

            security find-generic-password -D "AirPort network password" $ssid -gw
        case '*'
            echo >&2 Unknown command "'$cmd'".
            return 1
    end
end

function mac::flushdns -d 'Flush MacOS DNS Cache'
    dscacheutil -flushcache
    and killall -HUP mDNSResponder
end

function mac::lock-screen -d 'Lock the screen'
    /System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession \
        -suspend $argv
end

function mac::lsclean -d 'Clean LaunchServices to remove duplicate Open with...'
    /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
        -kill -r -domain local -domain system -domain user
    and killall Finder
end

function mac::vol -a action -d 'Set or show the Mac audio volume'
    if set -q action
        set action (string lower $action)
    else
        set action show
    end

    switch $action
        case mute
            osascript -e 'set volume output muted true'
        case unmute
            osascript -e 'set volume output muted false'
        case (seq 0 100)
            osascript -e "set volume output volume "$action
        case '*'
            osascript -e "output volume of (get volume settings)"
    end
end

function mac -a subcommand -d 'Manage several MacOS functions'
    set -e argv[1]

    switch (string lower $subcommand)
        case airdrop
            mac::airdrop $argv
        case airport
            mac::airport $argv
        case flushdns
            mac::flushdns $argv
        case lock-screen
            mac::lock-screen $argv
        case lsclean
            mac::lsclean $argv
        case vol
            mac::vol $argv
        case '*'
            echo >&2 'mac: Unknown command.'
            return 1
    end
end
