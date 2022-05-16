function __macos_airport_history
    defaults read \
        /Library/Preferences/SystemConfiguration/com.apple.airport.preferences | awk '/LastConnected/,/SecurityType/ {
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
