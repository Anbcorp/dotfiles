alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias mupdf='mupdf -r 84'
alias caps='cat | tr a-z A-Z'
function sshproxy() {

    ssh -f -N -D 127.0.0.1:$2 $1

}
