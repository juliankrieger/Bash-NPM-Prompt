function cd() {
  builtin cd "$@"

  if [[ -z "$NPM_ENV" ]] || [[ "$PWD" = "$NPM_ENV" ]] ; then
    ## If env folder is found then activate the vitualenv
      if [[ -f ./package.json ]] ; then
        export NPM_ENV="$PWD"
        export PS1="(\[\e[31m\]\W\[\e[m\]) [\u@\h \W\]\$ "
        #echo npm project found

      fi
  else
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing
    # else deactivate
      parentdir="$(dirname "$NPM_ENV")"
      if [ "${PWD##$NPM_ENV}" != "$PWD" ] ; then
        #echo stil in npm env
        export PS1="(\[\e[31m\]@$(basename $NPM_ENV)\[\e[m\]) [\u@\h \W ]\\$ "
      else
        #echo left npm env
        export PS1="[\u@\h \W]\$ "
        export NPM_ENV=""
      fi
  fi
}
