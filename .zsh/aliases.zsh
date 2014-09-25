alias ls='ls --color=auto'
alias grep='grep --color=auto'

function sshproxy() {

    ssh -f -N -D 127.0.0.1:$2 $1

}
