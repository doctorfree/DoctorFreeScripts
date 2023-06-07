#!/bin/bash
#
# get_all_repos - retrieve all github repos
#   requires gh and jq
#
# TODO: add argument processing for:
#   repo limit (-l #)
#   output dir (-o /path/to/src)
#   user (-u user)
#   and debug (-d)

OUTDIR="${HOME}/src"
user="doctorfree"

get_repo() {
  repo="$1"
  if [ -d ${repo} ]
  then
    echo "Performing git pull for ${repo}"
    cd ${repo}
    git pull > /dev/null 2>&1
    cd ..
  else
    echo "Cloning ${repo}"
    gh repo clone ${user}/${repo} > /dev/null 2>&1
  fi
}

[ -d "${OUTDIR}" ] || mkdir -p "${OUTDIR}"
cd "${OUTDIR}"

gh repo list --limit 200 --json name | \
jq --raw-output '.[]?.name' | \
while read name
do
  get_repo ${name}
done
