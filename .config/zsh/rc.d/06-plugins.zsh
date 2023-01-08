##
# Plugins
#

# Add the plugins you want to use here.
# For more info each plugin, visit its repo on github.com/<plugin>
# -a sets the variable's type to array.
local -a plugins=(
    #marlonrichert/zsh-autocomplete      # Real-time type-ahead completion
    marlonrichert/zsh-edit              # Better keyboard shortcuts
    marlonrichert/zsh-hist              # Edit history from the command line.
    marlonrichert/zcolors               # Colors for completions and Git
    zsh-users/zsh-autosuggestions       # Inline suggestions
    zsh-users/zsh-syntax-highlighting   # Command-line syntax highlighting
    zsh-users/zsh-history-substring-search # History substring search
)

# ianthehenry/zsh-autoquoter          # auto add quotes
# ZAQ_PREFIXES+=('git commit( [^ ]##)# -[^ -]#m')


# zsh-autocomplete sends *a lot* of characters to your terminal. This is fine
# locally on modern machines, but if you're working through a slow ssh
# connection, you might want to add a slight delay before the autocompletion
# kicks in:
# zstyle ':autocomplete:*' min-delay 1.0  # seconds
#
# If your connection is VERY slow, then you might want to disable
# autocompletion completely and use only tab completion instead:
# zstyle ':autocomplete:*' async no


# Speed up the first startup by cloning all plugins in parallel.
# This won't clone plugins that we already have.
znap clone $plugins

# Load each plugin, one at a time.
local p=
for p in $plugins; do
  znap source $p
done

# `znap eval <name> '<command>'` is like `eval "$( <command> )"` but with
# caching and compilation of <command>'s output, making it ~10 times faster.
znap eval zcolors zcolors   # Extra init code needed for zcolors.

# zstyle ':autocomplete:*' min-delay 1.0  # float
# Wait this many seconds for typing to stop, before showing completions.
#zstyle ':autocomplete:*' min-input 5  # int

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
# zstyle ':completion:*' menu select=1
# zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion


znap eval jira-eval '/usr/local/bin/jira --completion-script-zsh'
znap eval gh-eval '/usr/local/bin/gh completion --shell zsh'

[[ -s "/Users/evacchi/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/evacchi/.sdkman/bin/sdkman-init.sh"
