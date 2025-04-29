# @halostatue/fish-macos/functions/__macos_mac_mail.fish:v7.0.1

# Speed up Mail.app by vacuuming the Envelope Index
# - Code from: http://web.archive.org/web/20071008123746/http://www.hawkwings.net/2007/03/03/scripts-to-automate-the-mailapp-envelope-speed-trick/
# - Originally by "pmbuko" with modifications by Romulo
# - Updated by Brett Terpstra 2012
# - Updated by Mathias Törnblom 2015 to support V3 in El Capitan and still keep backwards compatibility
# - Updated by Andrei Miclaus 2017 to support V4 in Sierra
# - Updated by Austin Ziegler 2022 to not actually care what the OS version is (and translated to fish). The only
#   restriction is that you must have opened Mail.app at least once on any OS upgrade so that if any version changes
#   have happened, Mail.app has taken care of that for you.
function __macos_mac_mail
    argparse --name 'mac mail' h/help -- $argv
    or return 1

    if set --query _flag_help
        echo 'Usage: mac mail [options] SUBCOMMAND [arg]

Performs operations on Mail.app configuration and database.

Before running vacuum after any OS upgrade, Mail.app must have been opened
at least once so that the database and index formats have been updated.

Subcommands:
  vacuum                Vacuums the envelope index to improve performance.
  attachments inline    Sets Mail.app attachment handling to inline.
  attachments icon      Sets Mail.app attachment handling to icon.

Options:
  -h, --help               Show this help'
        return 0
    end

    set --function subcommand (string lower -- $argv[1])
    set --erase argv[1]

    switch $subcommand
        case vacuum
            set --function mail_version (
                path filter --type dir ~/Library/Mail/* |
                    path basename |
                    string match --all --entire --regex V\\d
            )
            set --function mail_path ~/Library/Mail/$mail_version/MailData/Envelope\ Index

            osascript -e 'tell application "Mail" to quit'

            set --function before (ls -lnah $mail_path | awk '{ print $5; }')
            /usr/bin/sqlite3 $mail_path vacuum
            set --function after (ls -lnah $mail_path | awk '{ print $5; }')

            printf "Mail index before: %s\nMail index after: %s\n" $before $after
            osascript -e 'tell application "Mail" to activate'

        case attachments
            switch (string lower -- $argv[1])
                case inline
                    defaults delete com.apple.mail DisableInlineAttachmentViewing
                case icon
                    defaults write com.apple.mail DisableInlineAttachmentViewing -bool true
            end

        case '*'
            echo >&2 'mac mail: Unknown command.'
            __macos_mac_mail --help >&2
            return 1
    end
end
