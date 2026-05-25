# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Add wisely, as too many plugins slow down shell startup.
#
# Note (Linux): on Mac these are sourced from /opt/homebrew. Here they are
# cloned into $ZSH_CUSTOM/plugins/ and loaded the oh-my-zsh way.
plugins=(git zsh-autosuggestions zsh-autocomplete)

source $ZSH/oh-my-zsh.sh

# User configuration

################################################################################
# Aliases
################################################################################

#------------------------------------------------------------------------------
# EZA Configuration
#------------------------------------------------------------------------------
# Next level of an ls
# options :  --no-filesize --no-time --no-permissions
alias ls="eza --no-filesize --long --color=always --icons=always --no-user"

#------------------------------------------------------------------------------
# TMUX Configuration
#------------------------------------------------------------------------------
# Only alias tmux when TMUX_CONF is set, otherwise call tmux directly.
if [[ -n "$TMUX_CONF" ]]; then
  alias tmux="tmux -f $TMUX_CONF"
fi
alias a="attach"
# calls the tmux new session script
alias tns="~/scripts/tmux-sessionizer"


################################################################################
# React Native Environment Configuration
################################################################################

# NVM (Linux install at $HOME/.nvm)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Java / Android (Linux paths)
export JAVA_HOME=/usr/lib/jvm/temurin-17-jdk-amd64
export ANDROID_HOME=/opt/android-sdk
export ANDROID_SDK_ROOT=$ANDROID_HOME
export PATH=$JAVA_HOME/bin:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH

################################################################################
# Development Tools Configuration
################################################################################

#------------------------------------------------------------------------------
# Core FZF Setup
#------------------------------------------------------------------------------
# Initialize FZF key bindings and completions for zsh
# Default key bindings:
#   - Ctrl+T: File search
#   - Alt+C: Directory navigation
#   - Ctrl+R: Command history search
eval "$(fzf --zsh)"

#------------------------------------------------------------------------------
# Preview Configuration
#------------------------------------------------------------------------------
# Configure intelligent preview for files and directories
# For files: Use bat with syntax highlighting and line numbers (limited to 500 lines)
# For directories: Use eza to show tree structure (limited to 200 lines)
# Note: --git-ignore flag makes eza respect .gitignore patterns
# Note (Linux): Debian ships `bat` as `batcat` and `fd-find` as `fdfind`;
#   we add /usr/local/bin/{bat,fd} symlinks so the same command names work here.
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --git-ignore --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

# Apply preview settings to different FZF commands
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --git-ignore --color=always {} | head -200'"

# Customize preview behavior based on command context
_fzf_comprun() {
 local command=$1
 shift

 case "$command" in
   cd)           fzf --preview 'eza --tree --git-ignore --color=always {} | head -200' "$@" ;;
   export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
   ssh)          fzf --preview 'dig {}'                   "$@" ;;
   *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
 esac
}

#------------------------------------------------------------------------------
# FD Integration (Fast Find Alternative)
#------------------------------------------------------------------------------
# Configure fd as the default command for file searching
# --hidden: Include hidden files/folders
# --strip-cwd-prefix: Remove ./ prefix from results
# --exclude .git: Ignore git directory
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
# Use same fd settings for Ctrl+T file search
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# Configure fd for Alt+C directory navigation (only show directories)
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

#------------------------------------------------------------------------------
# FZF Completion Functions
#------------------------------------------------------------------------------
# These functions enable fuzzy completion for:
#   - Files: Type ** and TAB (e.g., vim **/file.txt<TAB>)
#   - Directories: Type **/ and TAB (e.g., cd **/projects<TAB>)
#
# Path completion using fd
# $1: Base path to start traversal
_fzf_compgen_path() {
 fd --hidden --exclude .git . "$1"
}

# Directory completion using fd
# $1: Base path to start traversal
_fzf_compgen_dir() {
 fd --type=d --hidden --exclude .git . "$1"
}

#------------------------------------------------------------------------------
# Theme Configuration
#------------------------------------------------------------------------------
# Define colors
fg="#CBE0F0"          # Foreground text
bg="#011628"          # Background
bg_highlight="#143652" # Selected item background
purple="#B388FF"      # Highlighting
blue="#06BCE4"        # Info text
cyan="#2CF9ED"        # UI elements

# Apply color scheme
export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},\
bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},\
pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"

#------------------------------------------------------------------------------
# Zoxide Configuration (Smarter cd command)
#------------------------------------------------------------------------------
# Initialize zoxide for zsh
# This provides the following commands:
#   - z foo:    cd to highest ranked directory matching foo
#   - zi foo:   Interactive selection using fzf
#   - z foo/:   Only match directories with foo in name
#   - z ../foo: Regular cd-like behavior
eval "$(zoxide init --cmd cd zsh)"

#------------------------------------------------------------------------------
# History Management (Atuin)
#------------------------------------------------------------------------------
# Initialize Atuin for better history management
# Features:
#   - Sync history between machines
#   - Search by date, directory, or exit status
#   - Up arrow for local history, Alt-Up for global
# Note (Linux): atuin's installer drops the binary at ~/.atuin/bin, so we
#   source its env file BEFORE atuin init so the binary is on PATH.
[ -s "$HOME/.atuin/bin/env" ] && . "$HOME/.atuin/bin/env"
export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"
bindkey '^r' atuin-up-search-viins

#------------------------------------------------------------------------------
# Tmux Configuration
#------------------------------------------------------------------------------
# Initialize Tmux for better terminal management
# Features:
#   - Split panes - Ctrl+b %
#   - Resize panes - Ctrl+b <arrow>
#   - Navigate between panes - Ctrl+b o
#   - Navigate between windows - Ctrl+b c
#   - Navigate between sessions - Ctrl+b s
