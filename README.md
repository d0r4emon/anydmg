//anydmg  
//该插件去掉了dmg加载时的签名校验，现在我们可以加载自己修改过的DeveloperDiskImage啦！  
//  
  
//安装步骤:  
  
#1.找到对应版本的DeveloperDiskImage，例如：  
/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport/10.1/DeveloperDiskImage.dmg  
  
  
#2.解包到一个文件夹，例如~/myimg  
  
  
#3.修改~/myimg/usr/bin/debugserver  
$ cd ~/myimg/usr/bin/  
$ lipo -thin arm64 ./debugserver -output ./debugserver_arm64  
$ ldid -Sent.xml debugserver_arm64  
$ mv debugserver debugserver_old  
$ mv debugserver_arm64 debugserver  
  
  
#4.重新打包镜像  
$ cd ~  
$ hdiutil create -fs HFS+ -volname DeveloperDiskImage -srcfolder ./myimg -layout NONE -o DeveloperDiskImage_new.dmg  
  
  
#5.替换原镜像  
$ cd /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/DeviceSupport/10.1/  
$ mv DeveloperDiskImage.dmg DeveloperDiskImage_old.dmg  
$ cp ~/DeveloperDiskImage_new.dmg DeveloperDiskImage.dmg  
  
  
  
now! 拿起你的数据线，let's plug & play！  
  
  
参考：  
https://www.theiphonewiki.com/  
https://zhiwei.li/text/2011/06/29/developerdiskimage/  
http://cocoahuke.com/2015/08/30/Developer%E6%8C%82%E6%8E%A5%E4%BB%8B%E7%BB%8D/  
https://github.com/angelXwind/AppSync  
