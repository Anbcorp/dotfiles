ssh_key_manage() {
    if [[ -x $(which ssh-agent) ]] && ls $HOME/.ssh/id_?sa >& /dev/null; then
        if [[ -r $HOME/.ssh/agent-pid ]] ; then
            ps -p $(< $HOME/.ssh/agent-pid) 1>/dev/null
            if [[ $? == 0 || -d /proc/$(< $HOME/.ssh/agent-pid) ]]; then
                source $HOME/.ssh/agent
            else 
                ssh-agent -s > $HOME/.ssh/agent
                source $HOME/.ssh/agent
                echo $SSH_AGENT_PID > $HOME/.ssh/agent-pid
                ssh-add $HOME/.ssh/id_?sa
            fi  
        else 
            ssh-agent -s > $HOME/.ssh/agent
            source $HOME/.ssh/agent
            echo $SSH_AGENT_PID > $HOME/.ssh/agent-pid
            ssh-add $HOME/.ssh/id_?sa
        fi
    fi
}

gpg_agent_manage() {
    GPA_CONF=$HOME/.gnupg/agent
    GPA_PID=$HOME/.gnupg/agent-pid

    if [[ -x $(which gpg-agent) ]] >& /dev/null; then
        if [[ -r $GPA_PID ]]; then
            ps -p $(< $GPA_PID) 1>/dev/null
            if [[ $? == 0 || -d /proc/$(< $GPA_PID) ]]; then
                source $GPA_CONF
            else
                gpg-agent --daemon -s > $GPA_CONF
                source $GPA_CONF
                echo $(< $GPA_CONF) | cut -d: -f2 > $GPA_PID
            fi
        else
            gpg-agent --daemon -s > $GPA_CONF
            source $GPA_CONF
            echo $(< $GPA_CONF) | cut -d: -f2 > $GPA_PID
        fi
    fi
}

# ssh key management
if [[ "$USER" != "root" ]]; then
        ssh_key_manage
#        gpg_agent_manage
fi

