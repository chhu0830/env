setopt SHARE_HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# export LC_CTYPE=en_US.UTF-8
# export LC_ALL=en_US.UTF-8


# === Z-Shell ===
if [[ ! -f $HOME/.zi/bin/zi.zsh ]]; then
  print -P "%F{33}▓▒░ %F{160}Installing (%F{33}z-shell/zi%F{160})…%f"
  command mkdir -p "$HOME/.zi" && command chmod go-rwX "$HOME/.zi"
  command git clone -q --depth=1 --branch "main" https://github.com/z-shell/zi "$HOME/.zi/bin" && \
    print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
    print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi
source "$HOME/.zi/bin/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
# examples here -> https://wiki.zshell.dev/ecosystem/category/-annexes
# zicompinit_fast # <- https://wiki.zshell.dev/docs/guides/commands
# zi update --all
# zi update --reset
# zi update --quiet
# zi update --plugins
# zi update --snippets


# === Z-Shell Plugin ===
# zi ice lucid wait='0' atinit='zpcompinit'
# zi light zdharma/fast-syntax-highlighting
# zi ice wait lucid atinit='zicompinit_fast'
# zi light zsh-users/zsh-syntax-highlighting

# zi ice lucid wait='0' atload='_zsh_autosuggest_start; zpcompinit; zpcdreplay'
# zi ice wait lucid atload='_zsh_autosuggest_start'
# zi light zsh-users/zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion) # history)

# zstyle ':completion:*' menu yes select
# fpath=(~/data/env/vm/container/k8s/tool/kubectl/completion/zsh $fpath)
# zi ice wait lucid
# zi light zsh-users/zsh-completions

zi wait lucid light-mode for \
  atinit='zicompinit_fast' zsh-users/zsh-syntax-highlighting \
  atload='_zsh_autosuggest_start' zsh-users/zsh-autosuggestions \
  zsh-users/zsh-completions \

zi ice wait'!' lucid
zi snippet ~/.env/config/zcustom/zcustom.zsh

zi ice wait'!1' lucid
zi snippet ~/.env/config/zcustom/goenv.zsh

zi ice wait'!2' lucid
zi snippet ~/.env/config/zcustom/pyenv.zsh

zi ice wait'!3' lucid
zi snippet ~/.env/config/zcustom/nvm.zsh

# zi light olivierverdier/zsh-git-prompt
# ZSH_THEME_GIT_PROMPT_PREFIX="🐙"
# ZSH_THEME_GIT_PROMPT_SUFFIX=""
# ZSH_THEME_GIT_PROMPT_SEPARATOR=" "
# ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg_bold[magenta]%}"
# ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[red]%}%{●%G%}"
# ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%}%{✖%G%}"
# ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[blue]%}%{✚%G%}"
# ZSH_THEME_GIT_PROMPT_BEHIND="%{↓%G%}"
# ZSH_THEME_GIT_PROMPT_AHEAD="%{↑%G%}"
# ZSH_THEME_GIT_PROMPT_UNTRACKED="%{…%G%}"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}%{✔%G%}"


### Prompt ###
setopt prompt_subst
_lineup_=$'\e[1A'
_linedown_=$'\e[1B'
# REPORTTIME=1
# TMOUT=1
# TRAPALRM() {
#   zle reset-prompt
# }


autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' use-simple true
# zstyle ':vcs_info:git*' check-for-changes true
# zstyle ':vcs_info:git*' check-for-staged-changes true
# zstyle ':vcs_info:git*' stagedstr 'abc'
# zstyle ':vcs_info:git*' unstagedstr 'abc'
zstyle ':vcs_info:git*' formats '%b'
zstyle ':vcs_info:git*' actionformats '%b (%a)'
# branchformat

function _prompt_git() {
  default_timeout=0.5
  timeout=${timeout:-${default_timeout}}

  vcs_info
  ref="${vcs_info_msg_0_}"

  if [[ -n "${ref}" ]]; then
    if [[ "${ref/.../}" != "${ref}" ]]; then
      # detached
      ref="${ref/.../}🔒"
    fi

    ref="%F{008}${ref}%f"

    tracked=$(timeout ${timeout} git rev-list --left-right --count $(git branch --show-current)...origin/$(git branch --show-current) 2> /dev/null)
    ahead=$(echo ${tracked} | cut -f1)
    behind=$(echo ${tracked} | cut -f2)
    [[ ${behind} -gt 0 ]] && gittr="${gittr}%F{yellow}↓${behind}"
    [[ ${ahead} -gt 0 ]] && gittr="${gittr}%F{cyan}↑${ahead}"
    [[ -n ${gittr} ]] && ref="${ref}${gittr}"

    gitst=$(timeout ${timeout} git status --porcelain --ignore-submodules 2> /dev/null)
    if [[ $? -eq 0 ]]; then
      staged=$(echo ${gitst} | grep '^[AMDR]' | wc -l)
      changed=$(echo ${gitst} | grep -E '^ M|^MM' | wc -l)
      bothchanged=$(echo ${gitst} | grep '^UU' | wc -l)
      untracked=$(echo ${gitst} | grep '^??' | wc -l)
      deleted=$(echo ${gitst} | grep '^ D' | wc -l)
      gitst=""

      # ⌥ ⛕ ᛃ ↹  ᚴ ⥮ 
      [[ ${staged} -gt 0 ]] && gitst="${gitst}%F{cyan}ᚴ${staged}%f"
      [[ ${changed} -gt 0 ]] && gitst="${gitst}%F{yellow}±${changed}%f"
      [[ ${bothchanged} -gt 0 ]] && gitst="${gitst}%F{yellow}⥮${bothchanged}%f"
      [[ ${deleted} -gt 0 ]] && gitst="${gitst}%F{red}×${deleted}%f"
      [[ ${untracked} -gt 0 ]] && gitst="${gitst}%F{magenta}✶${untracked}%f"
      [[ -n ${gitst} ]] && ref="${ref} ${gitst}" || ref="${ref} %F{green}✓%f"
    fi
    print -Pn "🐙${ref}"
  fi
}

function _prompt_pyenv() {
  ([[ -n ${VIRTUAL_ENV} ]] && echo "🐍%F{yellow}${VIRTUAL_ENV##*/}%f ") ||
    (type pyenv &> /dev/null && [[ $(pyenv version-origin) != "${PYENV_ROOT}/version" ]] && echo "🐍%F{yellow}$(pyenv version-name)%f ")
    # [[ -n ${PYENV_VERSION} ]] && echo "🐍%F{yellow}${PYENV_VERSION}%f " ||
}

function _prompt_goenv() {
  # hash goenv 2> /dev/null && [[ $(goenv global) != $(goenv version-name) ]] && echo "🐶%F{cyan}$(goenv version-name)%f "
  type goenv &> /dev/null && [[ $(goenv version-origin) != "${GOENV_ROOT}/version" ]] && echo "🐶%F{cyan}$(goenv version-name)%f "
}

function _prompt_nvm() {
  type nvm &> /dev/null && [[ $(nvm version) != "system" ]] && echo "🐢%F{green}$(nvm version)%f "
}

function _prompt_exectime() {
  now=$(date +%s%3N)
  elapsed=$([ ${timer} ] && echo $((${now}-${timer})) || echo 0)

  d=$((elapsed / 1000 / 60 / 60 / 24))
  h=$((elapsed / 1000 / 60 / 60 % 24))
  m=$((elapsed / 1000 / 60 % 60))
  s=$((elapsed / 1000 % 60))
  ms=$((elapsed % 1000))

  exectime=""
  [[ ${d} -gt 0 ]] && exectime="${d}%F{magenta}d%f"
  [[ ${h} -gt 0 || -n ${exectime} ]] && exectime="${exectime}${h}%F{magenta}h%f"
  [[ ${m} -gt 0 || -n ${exectime} ]] && exectime="${exectime}${m}%F{magenta}m%f"
  [[ ${s} -gt 0 || -n ${exectime} ]] && exectime="${exectime}${s}%F{magenta}s%f"
  [[ ${ms} -gt 0 || -n ${exectime} ]] && exectime="${exectime}${ms}%F{magenta}ms%f"
  [[ -z ${exectime} ]] && exectime="${ms}%F{magenta}ms%f"

  echo "${exectime}"
}

function chpwd() {
  # prompt_git=$(_prompt_git)
}

function preexec() {
  timer=$(date +%s%3N)
}

function precmd() {
  timer=${timer:-$(date +%s%3N)}
  prompt_git=$(_prompt_git)
  prompt_goenv=$(_prompt_goenv)
  prompt_pyenv=$(_prompt_pyenv)
  prompt_nvm=$(_prompt_nvm)
  prompt_exectime=$(_prompt_exectime)
  unset timer

  PROMPT='👤%F{magenta}%n%f 💻%F{cyan}%m%f 📁%F{white}%~%f ${prompt_git}'$'\n''${prompt_goenv}${prompt_pyenv}${prompt_nvm}🐈%F{yellow}%f '
  # RPROMPT='%{${_lineup_}%}%(?.%F{green}✓.%F{red}💀%?)%f ⏳%F{white}${prompt_exectime}%f 🕑%F{yellow}%D{%H:%M:%S}%f%{${_linedown_}%}'
  RPROMPT='%(?.%F{green}✓.%F{red}💀%?)%f ⏳%F{white}${prompt_exectime}%f 🕑%F{yellow}%D{%H:%M:%S}%f'
  # ▓▒░ 🗸 ✓ ✗ ✘ ⌥ …±🖧 🖳
  # ⚡💎🐳🌟🏄🔥✨👀💾💡🚫❗📣📚📺💨🐣🐛💬🌀🚀🐯👋🏠🔮🧪🤖🔁🔂🔃🔄🔀🔖🧰🎉🌟👻
  # 🔴🟠🟡🟢🔵🟣
}


# Find exact Key code by <C-v> <key>
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[OA" up-line-or-beginning-search # Up
bindkey "^[OB" down-line-or-beginning-search # Down
bindkey "^[k" backward-word
bindkey "^[j" forward-word
bindkey "^[h" backward-char
bindkey "^[l" forward-char
bindkey "^k" up-line-or-beginning-search
bindkey "^j" down-line-or-beginning-search
bindkey '^f' forward-word
# bindkey -e

export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.TS=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'

### Alias ###
alias ls='ls --color=auto --group-directories-first'
