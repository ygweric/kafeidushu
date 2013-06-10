
# 2013-01-06
# 编译当前工程并打包
# 只产生一个ipa

#!/bin/sh

xcodebuild clean -configuration Distribution      #clean项目



 distDir=""
releaseDir="build/Release-iphoneos"
version=""
rm -rdf "$distDir"
mkdir -p "$distDir"
ipafilename=""
sourceid=`date '+%Y-%m-%d_%H-%M-%S'`
echo "ipafilename=$ipaname"
echo "sourceid=$sourceid"
targetName="Paging"   #项目名称(xcode左边列表中显示的项目名称)
appName="Paging"   #应用app名称(xcode左边列表中显示的项目名称)
echo "sourceid=$sourceid"
echo "ipafilename=$ipafilename"
echo "$sourceid" > sourceid.dat
echo "sourceid.dat: "
cat sourceid.dat
rm -rdf "$releaseDir"
mkdir -p "$releaseDir"

ipapath="${distDir}/${targetName}_${version}_at_${sourceid}.ipa"

echo "***开始build app文件***"
xcodebuild -target "$targetName" -configuration Distribution  -sdk iphoneos build
appfile="${releaseDir}/${appName}.app"
if [ $sourceid == "appstore" ]
then
cd $releaseDir
zip -r "${targetName}_${ipafilename}_${version}.zip" "${targetName}.app"
mv "${targetName}_${ipafilename}.zip" $distDir 2> /dev/null
cd ../..
else
echo "***开始打ipa渠道包****" 
sudo /usr/bin/xcrun -sdk iphoneos PackageApplication -v "$appfile" -o "$ipapath"
fi
