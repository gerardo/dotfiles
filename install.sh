#!/usr/bin/env bash

function link_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}" ]; then
       # It's not a directory and is identical
       if [ -f "${target}" ] &&  cmp $source $target &> /dev/null ; then
           echo "Identical: $target"
       else
          mv $target $target.bak
          echo "Linking $target"
          ln -sf ${source} ${target}
       fi
    else
        echo "Linking $target"
        ln -sf ${source} ${target}
    fi
}

echo "Linking dotfiles..."

for i in _*
  do
    link_file $i
  done

cd _vim/

vimfiles=( _vimrc _gvimrc )

for i in ${vimfiles[@]}
  do
    link_file $i
  done

cd ..

echo "Git syncing"

git submodule sync
git submodule init
git submodule update
git submodule foreach git pull origin master
git submodule foreach git submodule init
git submodule foreach git submodule update

echo "Done!"

