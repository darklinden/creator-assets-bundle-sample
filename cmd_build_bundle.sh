#!/bin/bash

killall -q CocosCreator

if [ $# -eq 1 ]; then
    folder=$1
    echo "pass arg "$folder
else
    echo 'need pass bundle project to build'
    exit -1
fi

if [ ! -d $folder ]; then
    echo 'need pass bundle project to build'
    exit -1
fi

cwd=$(pwd)

rsync -av --delete $cwd/common/assets/common/ $cwd/$folder/assets/common
cp $cwd/common/assets/common.meta $cwd/$folder/assets/common.meta
rsync -av --delete $cwd/common/assets/test/ $cwd/$folder/assets/test
cp $cwd/common/assets/test.meta $cwd/$folder/assets/test.meta

rm -rf $cwd/bundles/$folder

rm -rf $cwd/$folder/build
rm -rf $cwd/$folder/library
rm -rf $cwd/$folder/temp
rm -rf $cwd/$folder/local
rm -rf $cwd/$folder/profiles

echo '{"platform": "web-desktop","debug": false,"md5Cache": false}' >$cwd/$folder/config.json

/Applications/CocosCreator.app/Contents/MacOS/CocosCreator --project $cwd/$folder --configPath $cwd/$folder/config.json --build 'platform=web-desktop'
cp -r $cwd/$folder/build/web-desktop/remote/$folder $cwd/bundles/

anywhere -s -d $cwd/bundles
