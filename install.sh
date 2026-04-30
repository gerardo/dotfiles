#!/usr/bin/env bash

function link_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}" ]; then
       # It's not a directory and is identical
       if [ -f "${target}" ] &&  cmp "${source}" "${target}" &> /dev/null ; then
           echo "Identical: $target"
       else
          mv "${target}" "${target}.bak"
          echo "Linking $target"
          ln -sf "${source}" "${target}"
       fi
    else
        echo "Linking $target"
        ln -sf "${source}" "${target}"
    fi
}

function link_ghostty_config {
    source="${PWD}/_config.ghostty"
    target="${HOME}/.config/ghostty/config.ghostty"
    target_dir="$(dirname "${target}")"

    mkdir -p "${target_dir}"

    if [ -e "${target}" ]; then
       if [ -L "${target}" ] && [ "$(readlink "${target}")" = "${source}" ]; then
           echo "Identical: $target"
       elif [ -f "${target}" ] && cmp "${source}" "${target}" &> /dev/null ; then
           echo "Linking $target"
           ln -sf "${source}" "${target}"
       else
          mv "${target}" "${target}.bak"
          echo "Linking $target"
          ln -sf "${source}" "${target}"
       fi
    else
        echo "Linking $target"
        ln -sf "${source}" "${target}"
    fi
}

function link_config_directory {
    source="${PWD}/$1"
    target="${HOME}/$2"
    target_dir="$(dirname "${target}")"

    mkdir -p "${target_dir}"

    if [ -e "${target}" ]; then
       if [ -L "${target}" ] && [ "$(readlink "${target}")" = "${source}" ]; then
           echo "Identical: $target"
       else
          mv "${target}" "${target}.bak"
          echo "Linking $target"
          ln -sf "${source}" "${target}"
       fi
    else
        echo "Linking $target"
        ln -sf "${source}" "${target}"
    fi
}

function remove_stale_vim_links {
    for target in "${HOME}/.vim" "${HOME}/.vimrc" "${HOME}/.gvimrc"
      do
        if [ -L "${target}" ]; then
            link_target="$(readlink "${target}")"
            case "${link_target}" in
                "${PWD}/_vim"|"${PWD}/_vim/"*)
                    echo "Removing stale Vim link: ${target}"
                    rm "${target}"
                    ;;
            esac
        fi
      done
}

echo "Linking dotfiles..."

for i in _*
  do
    case "$i" in
      _config.ghostty|_config.nvim)
        ;;
      *)
        link_file "$i"
        ;;
    esac
  done

link_ghostty_config
link_config_directory "_config.nvim" ".config/nvim"
remove_stale_vim_links

echo "Git syncing in main directory"

git submodule sync
git submodule init
git submodule update
git submodule foreach git pull origin master
git submodule foreach git submodule init
git submodule foreach git submodule update

echo "Git syncing in _zsh  directory"

cd _zsh/ || exit

git submodule sync
git submodule init
git submodule update
git submodule foreach git pull origin master
git submodule foreach git submodule init
git submodule foreach git submodule update

echo "Done!"
