#!/bin/bash

set -e

yuzu_dir='/root/yuzu'
yuzu_git_url='https://github.com/yuzu-emu/yuzu-mainline'

while getopts :r arg
do
    case "${arg}" in
        r) rebuild=true ;;
    esac
done

[[ $rebuild = true ]] && [[ -d $yuzu_dir ]] && rm -rf $yuzu_dir
[[ ! -d $yuzu_dir ]] && mkdir $yuzu_dir && rebuild=true

[[ $rebuild = true ]] && git clone --recursive $yuzu_git_url $yuzu_dir

# perform git pull
pushd $yuzu_dir
git pull --recurse-submodules
popd

# remove build directory
[[ -d $yuzu_dir/build ]] && rm -rf $yuzu_dir/build

# build yuzu
pushd $yuzu_dir
#cmake -S . -B build -GNinja -DYUZU_USE_BUNDLED_VCPKG=ON -DYUZU_TESTS=OFF -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang -DYUZU_USE_BUNDLED_SDL2=OFF -DYUZU_USE_EXTERNAL_SDL2=OFF
cmake -S . -B build -GNinja -DYUZU_USE_BUNDLED_VCPKG=ON -DYUZU_TESTS=OFF -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang
cmake --build build
popd

rsync -vr --delete --exclude='.gitignore' $yuzu_dir/build/bin/ /output/
