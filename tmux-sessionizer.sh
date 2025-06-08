#!/usr/bin/env bash


function help () {
  cat <<EOF
This script enables you to interactivly open projects in new tmux sessions
If the session already exists, instead it will attach you to that session
This script requires that you pass the absolute paths of directories 
where you projects reside.
You can set TMUX_SESSIONIZER_HIDE_BASE_PATH environment variable if you want to
hide the base path from the the menu. This is useful if you have long paths.

EOF
}

if [[ $# -eq 0 ]] || [[ $1 =~ ^(help|--help|-h)$ ]]; then
  help
  echo -e "\nYou need to provide absolute paths as arguments to this script"
  exit 1
fi

[[ -n "${TMUX_SESSIONIZER_HIDE_BASE_PATH}" ]] && base_path="${TMUX_SESSIONIZER_HIDE_BASE_PATH}"

# Arguments are supported absolute paths
# This is made so that it can be used for different cases and makes it a lot more flexible
# For example, if you have nfs and also local files, you want to separate those two so
# that when you search local files, it doesn't have to traverse the nfs file system and
# slows down your local search/flow. You can have separate bindings for those two actions
declare -a directories=( $@ )

# Directories that will be ignored
ignore_directories=(
  '.pytest_cache'
  '.test'
  '.idea'
  '.git'
  '.empty'
  '.jupyter'
  '.virtual_documents'
  '__pycache__'
  '.ipynb_checkpoints'
)

dirs=$(find "${directories[@]}" -type d -maxdepth 1 -mindepth 1 $(printf "! -path **/%s " ${ignore_directories[@]}) )
# Add also the provided paths as options
dirs+=$(printf "\n%s" ${directories[@]})

selected="$(echo "${dirs}" | sed "s|^${base_path}/||" | sort -f | sk --margin 20% --color bw)"

if [[ -z $selected ]]; then
  exit 0
fi

selected_name="$(sed 's/[\ ./]/_/g' <<< ${selected})"
if [[ $(wc -c <<< "${selected_name}") -gt 20 ]]; then
  selected_name="$(awk -F'_' '{print $NF}' <<< "${selected_name}")"
fi


# tmux_running="$(pgrep tmux)"
# if [[ -z "${TMUX}" ]] && [[ -z "${tmux_running}" ]]; then
#   tmux new-session -s "${selected_name}" -c "${base_path}/${selected}"
# fi

if ! $(tmux has-session -t="${selected_name}" 2> /dev/null); then
  tmux new-session -ds "${selected_name}" -c "${base_path}/${selected}" 
  tmux rename-window -t 1 "${selected_name}-1"
  tmux new-window -t "${selected_name}":2 -n "${selected_name}-2" -c "${base_path}/${selected}"
  tmux new-window -t "${selected_name}":3 -n "${selected_name}-3" -c "${base_path}/${selected}"
  tmux select-window -t "${selected_name}":1
fi

if [[ -z "${TMUX}" ]]; then
  tmux attach -t "${selected_name}"
else
  tmux switch-client -t "${selected_name}"
fi

