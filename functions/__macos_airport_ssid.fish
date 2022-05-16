function __macos_airport_ssid
    __macos_airport_run -I | awk '/ SSID/ { print $2; }'
end
