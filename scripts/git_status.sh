#!/usr/bin/env bash
#
# git_status [-q] [-r] config_dir
#   -q indicates return short status string, one of:
#     "Up-to-date"
#     "Updates available"
#     "Local changes"
#     "Diverged"
#   -r indicates rich-cli rather than echo/printf (only if no -q)

query=
rich=
[ "$1" == "-q" ] && {
  query=1
  shift
}
[ "$1" == "-r" ] && {
  rich=1
  shift
}
gpath="$1"
tpath=$(echo "${gpath}" | sed -e "s%${HOME}%~%")
git -C "${gpath}" remote update >/dev/null 2>&1
UPSTREAM=${2:-'@{u}'}
LOCAL=$(git -C "${gpath}" rev-parse @)
REMOTE=$(git -C "${gpath}" rev-parse "$UPSTREAM")
BASE=$(git -C "${gpath}" merge-base @ "$UPSTREAM")

if [ $LOCAL = $REMOTE ]; then
  if [ "${query}" ]; then
    echo "Up-to-date"
  else
    if [ "${rich}" ]; then
      printf "  %-45s" "${tpath}"
      rich "  [b green]Up-to-date [/]" -p
    else
      printf "\n  %-45s  Up-to-date " "${tpath}"
    fi
  fi
elif [ $LOCAL = $BASE ]; then
  if [ "${query}" ]; then
    echo "Updates available"
  else
    if [ "${rich}" ]; then
      printf "  %-45s" "${tpath}"
      rich "  [b yellow]Updates available[/]" -p
    else
      printf "\n  %-45s  Updates available" "${tpath}"
    fi
    if [ "${rich}" ]; then
      rich "    Update with: [b cyan]lazyman -U -N ${neovim}[/]" -p
    else
      printf "\n    Update with: lazyman -U -N ${neovim}"
    fi
  fi
elif [ $REMOTE = $BASE ]; then
  if [ "${query}" ]; then
    echo "Local changes"
  else
    if [ "${rich}" ]; then
      printf "  %-45s" "${tpath}"
      rich "  [b orange]Local changes to tracked files[/]" -p
    else
      printf "\n  %-45s  Local changes to tracked files" "${tpath}"
    fi
    if [ "${rich}" ]; then
      rich "    Backup any local changes prior to running [b cyan]lazyman -U -N ${neovim}[/]" -p
    else
      printf "\n    Backup any local changes prior to running 'lazyman -U -N ${neovim}'"
    fi
  fi
else
  if [ "${query}" ]; then
    echo "Diverged"
  else
    if [ "${rich}" ]; then
      printf "  %-45s" "${tpath}"
      rich "  [b red]Appears to have diverged[/]" -p
    else
      printf "\n  %-45s  Appears to have diverged" "${tpath}"
    fi
    if [ "${rich}" ]; then
      rich "    Backup any local changes prior to running [b cyan]lazyman -U -N ${neovim}[/]" -p
    else
      printf "\n    Backup any local changes prior to running 'lazyman -U -N ${neovim}'"
    fi
  fi
fi
