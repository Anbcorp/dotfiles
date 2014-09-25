autoload -U colors
colors

setopt prompt_subst
source /usr/lib/git-core/git-sh-prompt


myprompt=$'%{$fg[green]%}%n$reset_color@$fg[yellow]%m %{$reset_color%}%{$fg[white]%}[${PWD/#$HOME/~}]%{$reset_color%} \
'

GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto"
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWDIRTYSTATE=1
precmd () {
    __git_ps1 "$myprompt" "%#%{$reset_color%} " "{%s}" 
}
#PROMPT=$'%{$fg[green]%}%n$reset_color@$fg[yellow]%m %{$reset_color%}%{$fg[white]%}[${PWD/#$HOME/~}]%{$reset_color%} \
#$(__git_ps1 " {%s}")%#%{$reset_color%} '

__virt_env () {
    if ! [ -z $VIRTUAL_ENV ]; then
        echo -n "%{$fg[magenta]%}($(basename $VIRTUAL_ENV))%{$reset_color%}"
    else
        echo -n ''
    fi
}

RPROMPT=$'%{$fg[magenta]%}$(__virt_env)%{$fg[blue]%}%D{[%H:%M:%S]}%{$reset_color%}'
