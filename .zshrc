# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
 export PATH=$HOME/bin:/usr/local/bin:$PATH
 
export ZSH="/home/angelo/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"

# DEFAULT_USER=$USER

# Set the suggestions color for zsh-autosuggest
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=yellow"

# Ctrl+Space to accept suggestion
bindkey '^ ' autosuggest-accept

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
#ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git sudo command-not-found docker zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
alias zshconfig="vim ~/.zshrc"
#alias ohmyzsh="mate ~/.oh-my-zsh"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#todo.txt alias
alias todo="~/todo.sh"

#todo.txt autocompletion
_todo()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"

    local -r OPTS="-@ -@@ -+ -++ -d -f -h -p -P -PP -a -n -t -v -vv -V -x"
    local -r COMMANDS="\
        add a addto addm append app archive command del  \
        rm depri dp do help list ls listaddons listall lsa listcon  \
        lsc listfile lf listpri lsp listproj lsprj move \
        mv prepend prep pri p replace report shorthelp"
    local -r MOVE_COMMAND_PATTERN='^(move|mv)$'

    local _todo_sh=${_todo_sh:-todo.sh}
    local completions
    if [ $COMP_CWORD -eq 1 ]; then
        completions="$COMMANDS $(eval TODOTXT_VERBOSE=0 $_todo_sh command listaddons 2>/dev/null) $OPTS"
    elif [[ $COMP_CWORD -gt 2 && ( \
        "${COMP_WORDS[COMP_CWORD-2]}" =~ $MOVE_COMMAND_PATTERN || \
        "${COMP_WORDS[COMP_CWORD-3]}" =~ $MOVE_COMMAND_PATTERN ) ]]; then
        # "move ITEM# DEST [SRC]" has file arguments on positions 2 and 3.
        completions=$(eval TODOTXT_VERBOSE=0 $_todo_sh command listfile 2>/dev/null)
    else
        case "$prev" in
            command)
                completions=$COMMANDS;;
            help)
                completions="$COMMANDS $(eval TODOTXT_VERBOSE=0 $_todo_sh command listaddons 2>/dev/null)";;
            addto|listfile|lf)
                completions=$(eval TODOTXT_VERBOSE=0 $_todo_sh command listfile 2>/dev/null);;
            -*) completions="$COMMANDS $(eval TODOTXT_VERBOSE=0 $_todo_sh command listaddons 2>/dev/null) $OPTS";;
            *)  case "$cur" in
                    +*) completions=$(eval TODOTXT_VERBOSE=0 $_todo_sh command listproj 2>/dev/null)
                        COMPREPLY=( $( compgen -W "$completions" -- $cur ))
                        [ ${#COMPREPLY[@]} -gt 0 ] && return 0
                        # Fall back to projects extracted from done tasks.
                        completions=$(eval 'TODOTXT_VERBOSE=0 TODOTXT_SOURCEVAR=\$DONE_FILE' $_todo_sh command listproj 2>/dev/null)
                        ;;
                    @*) completions=$(eval TODOTXT_VERBOSE=0 $_todo_sh command listcon 2>/dev/null)
                        COMPREPLY=( $( compgen -W "$completions" -- $cur ))
                        [ ${#COMPREPLY[@]} -gt 0 ] && return 0
                        # Fall back to contexts extracted from done tasks.
                        completions=$(eval 'TODOTXT_VERBOSE=0 TODOTXT_SOURCEVAR=\$DONE_FILE' $_todo_sh command listcon 2>/dev/null)
                        ;;
                    *)  if [[ "$cur" =~ ^[0-9]+$ ]]; then
                            # Remove the (padded) task number; we prepend the
                            # user-provided $cur instead.
                            # Remove the timestamp prepended by the -t option,
                            # and the done date (for done tasks); there's no
                            # todo.txt option for that yet.
                            # But keep priority and "x"; they're short and may
                            # provide useful context.
                            # Remove any trailing whitespace; the Bash
                            # completion inserts a trailing space itself.
                            # Finally, limit the output to a single line just as
                            # a safety check of the ls action output.
                            local todo=$( \
                                eval TODOTXT_VERBOSE=0 $_todo_sh '-@ -+ -p -x command ls "^ *${cur} "' 2>/dev/null | \
                                sed -e 's/^ *[0-9]\{1,\} //' -e 's/^\((.) \)\{0,1\}[0-9]\{2,4\}-[0-9]\{2\}-[0-9]\{2\} /\1/' \
                                    -e 's/^\([xX] \)\([0-9]\{2,4\}-[0-9]\{2\}-[0-9]\{2\} \)\{1,2\}/\1/' \
                                    -e 's/[[:space:]]*$//' \
                                    -e '1q' \
                            )
                            # Append task text as a shell comment. This
                            # completion can be a safety check before a
                            # destructive todo.txt operation.
                            [ "$todo" ] && COMPREPLY[0]="$cur # $todo"
                            return 0
                        else
                            return 0
                        fi
                        ;;
                esac
                ;;
        esac
    fi

    COMPREPLY=( $( compgen -W "$completions" -- $cur ))
    return 0
}
complete -F _todo todo.sh
complete -F _todo t

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[[ -s "/home/angelo/.gvm/scripts/gvm" ]] && source "/home/angelo/.gvm/scripts/gvm"
