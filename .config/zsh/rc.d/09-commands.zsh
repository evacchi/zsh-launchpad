#!/bin/zsh

##
# Commands, funtions and aliases
#
# Always set aliases _last,_ so they don't class with function definitions.
#


function declang() {
   clang -g -O0 -c -emit-llvm -pipe -x c -o - $1 | llvm-dis | less
}

function dejavac() {
   javac $1
   javap -va ${1/.java/.class} | less
}

function fastmaven() {
  export MAVEN_OPTS=-XX:TieredStopAtLevel=1
}

function mvndir() {
  dirname `mvn help:evaluate -Dexpression=project.build.directory -q -DforceStdout -pl $1`
}

function cdmvn() {
  cd `mvndir $1`
}

function jlog() {
  local SUFFIX=/display/redirect
  curl ${1/$SUFFIX}/consoleText
} 

function dtree() {
  local U=$1
  mvn dependency:get -Dartifact=$U
  local BASEDIR=`mvn help:evaluate -Dartifact=$U -q -DforceStdout -Dexpression=project.basedir`
  local ARTIFACT_NAME=`mvn help:evaluate -Dartifact=$U -q -DforceStdout -Dexpression=project.build.finalName`
  #mvn dependency:tree -f $HOME/.m2/repository/$groupIdPath/$artifactId/$version/$artifactId-$version.pom
  mvn dependency:tree -f $BASEDIR/$ARTIFACT_NAME.pom
}

function j() { 
  if [[ "$@" == "" ]]; then 
    jira now
  else
    jira "$@"
  fi
}

export JIRA_API_TOKEN=OTE1NTA1Nzg1Mjg2OrG5X1tpjMrpkF1QRPMkGYfJjEao

# These aliases enable us to paste example code into the terminal without the
# shell complaining about the pasted prompt symbol.
alias %= \$=


# zmv lets you batch rename (or copy or link) files by using pattern matching.
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#index-zmv
autoload -Uz zmv
alias zmv='zmv -Mv'
alias zcp='zmv -Cv'
alias zln='zmv -Lv'

# Note that, unlike Bash, there's no need to inform Zsh's completion system
# of your aliases. It will figure them out automatically.


alias l='ls -1A'         # Lists in one column, hidden files.
alias ll='ls -lh'        # Lists human readable sizes.
alias lr='ll -R'         # Lists human readable sizes, recursively.
alias la='ll -A'         # Lists human readable sizes, hidden files.
alias lm='la | "$PAGER"' # Lists human readable sizes, hidden files through pager.
alias lx='ll -XB'        # Lists sorted by extension (GNU only).
alias lk='ll -Sr'        # Lists sorted by size, largest last.
alias lt='ll -tr'        # Lists sorted by date, most recent last.
alias lc='lt -c'         # Lists sorted by date, most recent last, shows change time.
alias lu='lt -u'         # Lists sorted by date, most recent last, shows access time.
alias sl='ls'            # I often screw this up.

# Define colors for BSD ls.
#export LSCOLORS='exfxcxdxbxGxDxabagacad'

# Define colors for the completion system.
#export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=36;01:cd=33;01:su=31;40;07:sg=36;40;07:tw=32;40;07:ow=33;40;07:'

alias ls="${aliases[ls]:-ls} -G"



# Grep
export GREP_COLOR='37;45'           # BSD.
export GREP_COLORS="mt=$GREP_COLOR" # GNU.

alias grep="${aliases[grep]:-grep} --color=auto"


# Set $PAGER if it hasn't been set yet. We need it below.
# `:` is a builtin command that does nothing. We use it here to stop Zsh from
# evaluating the value of our $expansion as a command.
: ${PAGER:=less}


# # Associate file .extensions with programs.
# # This lets you open a file just by typing its name and pressing enter.
# # Note that the dot is implicit. So, `gz` below stands for files ending in .gz
# alias -s {css,gradle,html,js,json,md,patch,properties,txt,xml,yml}=$PAGER
# alias -s gz='gzip -l'
# alias -s {log}='tail -F'


# Use `< file` to quickly view the contents of any file.
READNULLCMD=$PAGER  # Set the program to use for this.
