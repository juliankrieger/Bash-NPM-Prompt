PS1_ORIG=$PS1

function cd() {
  builtin cd "$@"

  if [[ -z "$NPM_ENV" ]] || [[ "$PWD" = "$NPM_ENV" ]] ; then
    ## If env folder is found then activate the vitualenv
      if [[ -f ./package.json ]] ; then
        export NPM_ENV="$PWD"
        export PS1="(\[\e[31m\]$(basename $NPM_ENV)\[\e[m\]) $PS1_ORIG"
      fi
  else
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing
    # else deactivate
      # NPM PATH - Current Path = Current Path (no common path, starting from left, found)
      if [ "${PWD##$NPM_ENV}" = "$PWD" ] ; then
        export PS1=$PS1_ORIG
        export NPM_ENV=""
      fi
  fi
}
