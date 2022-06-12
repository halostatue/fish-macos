# Speed up Mail.app by vacuuming the Envelope Index
# - Code from: http://web.archive.org/web/20071008123746/http://www.hawkwings.net/2007/03/03/scripts-to-automate-the-mailapp-envelope-speed-trick/
# - Originally by "pmbuko" with modifications by Romulo
# - Updated by Brett Terpstra 2012
# - Updated by Mathias Törnblom 2015 to support V3 in El Capitan and still keep backwards compatibility
# - Updated by Andrei Miclaus 2017 to support V4 in Sierra
# - Updated by Austin Ziegler 2022 to not actually care what the OS version is (and translated to fish). The only
#   restriction is that you must have opened Mail.app at least once on any OS upgrade so that if any version changes
#   have happened, Mail.app has taken care of that for you.
function __macos_mail
    set -l subcommand $argv[1]
    set -e argv[1]

    switch (string lower $subcommand)
        case vacuum
            set -l mail_version (ls -l ~/Library/Mail | string match -a -e -r V\\d)
            set -l mail_path ~/Library/Mail/$mail_version/MailData/Envelope\ Index

            osascript -e 'tell application "Mail" to quit'
            set -l before (ls -lnah $mail_path | awk '{ print $5; }')
            /usr/bin/sqlite3 $mail_path vacuum
            set -l after (ls -lnah $mail_path | awk '{ print $5; }')

            osascript -e "display dialog (\"Mail index before: $before\" & return & \"Mail index after: $after\" & return)"
            osascript -e 'tell application "Mail" to activate'

        case attachments
            switch (string lower $argv1)
                case inline
                    defaults delete com.apple.mail DisableInlineAttachmentViewing
                case icon
                    defaults write com.apple.mail DisableInlineAttachmentViewing -bool true
            end

        case '*'
            echo >&2 Unknown command "'$subcommand'".
            return 1
    end
end
