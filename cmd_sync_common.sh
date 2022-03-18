#!/bin/bash

cwd=$(pwd)
bundle_list=$(ls | grep "^bundle-.*")
for folder in $bundle_list; do
    echo ''
    echo 'sync '$cwd/$folder
    rsync -av --delete $cwd/common/assets/common/ $cwd/$folder/assets/common
    cp $cwd/common/assets/common.meta $cwd/$folder/assets/common.meta
    rsync -av --delete $cwd/common/assets/test/ $cwd/$folder/assets/test
    cp $cwd/common/assets/test.meta $cwd/$folder/assets/test.meta
done
