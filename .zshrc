export PATH=$HOME/bin:$HOME/src/dotfiles/helpers:/opt/boxen/bin:/usr/local/bin:$PATH
source ~/.bashrc
autoload colors zsh/terminfo

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="better"
#ZSH_THEME="agnoster"

alias zconf="vim ~/.zshrc"
alias zreload="source ~/.zshrc"

alias gs="git status"
alias gd="git diff $@"
alias gdc="git diff --cached $@"
alias gsu="git submodule update"

# red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

export EDITOR='vim'
# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

#directory profiles for git!
#
## Thanks to: Michael Prokop. 
## More documentation: 
## http://git.grml.org/?p=grml-etc-core.git;f=etc/zsh/zshrc;hb=HEAD#l1120
##
CHPWD_PROFILE='default'
function chpwd_profiles() {
    local -x profile

    zstyle -s ":chpwd:profiles:${PWD}" profile profile || profile='default'
    if (( ${+functions[chpwd_profile_$profile]} )) ; then
        chpwd_profile_${profile}
    fi

    CHPWD_PROFILE="${profile}"
    return 0
}
chpwd_functions=( ${chpwd_functions} chpwd_profiles )


#profile definitions
zstyle ':chpwd:profiles:/Users/jtrinklein/src(|/|/*)'  profile work
zstyle ':chpwd:profiles:/Users/jtrinklein/Repos(|/|/*)'   profile fun

#default profile
chpwd_profile_default()
{
    [[ ${profile} == ${CHPWD_PROFILE} ]] && return 1
    print "chpwd(): Switching to profile: default"

    rm ~/.ssh/id_rsa
    rm ~/.ssh/id_rsa.pub
    cp ~/.ssh/jtrinklein_rsa ~/.ssh/id_rsa
    cp ~/.ssh/jtrinklein_rsa.pub ~/.ssh/id_rsa.pub
    export GIT_AUTHOR_EMAIL="default@example.com"
    export GIT_COMMITTER_EMAIL="default@example.com"
}

#work profile
chpwd_profile_work()
{
    [[ ${profile} == ${CHPWD_PROFILE} ]] && return 1
    print "chpwd(): Switching to profile: work"
    
    rm ~/.ssh/id_rsa
    rm ~/.ssh/id_rsa.pub
    cp ~/.ssh/jtrinklein_rsa ~/.ssh/id_rsa
    cp ~/.ssh/jtrinklein_rsa.pub ~/.ssh/id_rsa.pub

    export GIT_AUTHOR_EMAIL="jtrinklein@daptiv.com"
    export GIT_COMMITTER_EMAIL="jtrinklein@daptiv.com"
}

#fun profile
chpwd_profile_fun()
{
    [[ ${profile} == ${CHPWD_PROFILE} ]] && return 1
    print "chpwd(): Switching to profile: fun"
    
    rm ~/.ssh/id_rsa
    rm ~/.ssh/id_rsa.pub
    cp ~/.ssh/jamest_rsa ~/.ssh/id_rsa
    cp ~/.ssh/jamest_rsa.pub ~/.ssh/id_rsa.pub

    export GIT_AUTHOR_EMAIL="theotherjim@gmail.com"
    export GIT_COMMITTER_EMAIL="theotherjim@gmail.com"
}

chpwd_profile_default # run DEFAULT profile automatically
