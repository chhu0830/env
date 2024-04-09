#!/bin/bash

# define your own functions with name start with `_`, or by putting
# scripts under folder with the same name of the script

helpmsg() {
  echo "usage: ${pcmd}{${buildin}$([[ -n ${buildin} ]] && [[ -n ${cmdList} ]] && echo -n '|')${cmdList}}" ${@}
}

_help() {
  helpmsg
}

default() {
  _help
}

cmd() {
  cd $(dirname $(realpath ${0}))
  export pcmd="${pcmd}$(basename $(caller | cut -d " " -f 2) .sh) "

  cmdPath="./$(basename ${0} .sh)"
  cmdList=$(ls -m ${cmdPath} 2> /dev/null | sed -e 's/\.sh, /|/g' | sed -e 's/\.sh//g')
  buildin=$(declare -F -p | cut -d " " -f 3 | grep ^_ | tr -d '_' | tr '\n' '|' | sed 's/|$//')

  shopt -s extglob
  case ${1} in
    '')
      default
      ;;
    $(echo "@($buildin)"))
      _${1} ${@:2}
      ;;
    $(echo "@($cmdList)"))
      bash ${cmdPath}/${1}.sh ${@:2}
      ;;
    *)
      _help
      ;;
  esac
}

if [[ "${0}" == "${BASH_SOURCE[0]}" ]]; then
  cmd ${@}
fi
