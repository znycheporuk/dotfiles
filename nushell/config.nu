use ~/.cache/starship/init.nu

$env.config = {
    show_banner: false,
    ls: {
        use_ls_colors: true # use the LS_COLORS environment variable to colorize output
        clickable_links: true # enable or disable clickable links. Your terminal has to support links.
    }

    rm: {
        always_trash: false # always act as if -t was given. Can be overridden with -p
    }

    table: {
        mode: rounded # basic, compact, compact_double, light, thin, with_love, rounded, reinforced, heavy, none, other
        index_mode: always # "always" show indexes, "never" show indexes, "auto" = show indexes when a table has "index" column
        show_empty: true # show 'empty list' and 'empty record' placeholders for command output
        padding: { left: 1, right: 1 } # a left right padding of each column in a table
        trim: {
            methodology: wrapping # wrapping or truncating
            wrapping_try_keep_words: true # A strategy used by the 'wrapping' methodology
            truncating_suffix: "..." # A suffix used by the 'truncating' methodology
        }
        header_on_separator: false # show header text on separator/border line
        # abbreviated_row_count: 10 # limit data rows from top and bottom after reaching a set point
    }

    error_style: "fancy" # "fancy" or "plain" for screen reader-friendly error messages

    # datetime_format determines what a datetime rendered in the shell would look like.
    # Behavior without this configuration point will be to "humanize" the datetime display,
    # showing something like "a day ago."
    datetime_format: {
        # normal: '%a, %d %b %Y %H:%M:%S %z'    # shows up in displays of variables or other datetime's outside of tables
        # table: '%m/%d/%y %I:%M:%S%p'          # generally shows up in tabular outputs such as ls. commenting this out will change it to the default human readable datetime format
    }

    explore: {
        status_bar_background: { fg: "#1D1F21", bg: "#C4C9C6" },
        command_bar_text: { fg: "#C4C9C6" },
        highlight: { fg: "black", bg: "yellow" },
        status: {
            error: { fg: "white", bg: "red" },
            warn: {}
            info: {}
        },
        selected_cell: { bg: light_blue },
    }

    history: {
        max_size: 100_000 # Session has to be reloaded for this to take effect
        sync_on_enter: true # Enable to share history between multiple sessions, else you have to close the session to write history to file
        file_format: "plaintext" # "sqlite" or "plaintext"
        isolation: false # only available with sqlite file_format. true enables history isolation, false disables it. true will allow the history to be isolated to the current session using up/down arrows. false will allow the history to be shared across all sessions.
    }

    completions: {
        case_sensitive: false # set to true to enable case-sensitive completions
        quick: true    # set this to false to prevent auto-selecting completions when only one remains
        partial: true    # set this to false to prevent partial filling of the prompt
        algorithm: "prefix"    # prefix or fuzzy
        external: {
            enable: true # set to false to prevent nushell looking into $env.PATH to find more suggestions, `false` recommended for WSL users as this look up may be very slow
            max_results: 100 # setting it lower can improve completion performance at the cost of omitting some options
            completer: null # check 'carapace_completer' above as an example
        }
        use_ls_colors: true # set this to true to enable file/path/directory completions using LS_COLORS
    }

    filesize: {
        unit: "metric"
    }

}

alias dcu = docker compose up
alias dcd = docker compose down

source ~/.cache/carapace/init.nu
