

1. [iOS-OC、Swift 混编之桥接文件](https://www.cnblogs.com/wangkejia/p/7891374.html)
2. [iOS 11上定位有权限问题，如何解决？](https://lbs.amap.com/faq/location/location-develop/ios11locsetting)
3. [iOS 发送HTTP请求报错](https://www.jianshu.com/p/29257388b8cb)
4. [Updated to iOS 12.1/Xcode 10.1 and getting a flood of "Signal strength query returned error](https://forums.developer.apple.com/thread/111334)
5. [Hide strange unwanted Xcode logs](https://stackoverflow.com/questions/37800790/hide-strange-unwanted-xcode-logs)


```
git --no-optional-locks -c color.branch=false -c color.diff=false -c color.status=false -c diff.mnemonicprefix=false -c core.quotepath=false -c credential.helper=sourcetree -c lfs.customtransfer.bitbucket-media-api.path=/Applications/Sourcetree.app/Contents/Resources/git_local/git-lfs/git-lfs-bitbucket-media-api push -v --tags origin refs/heads/master:refs/heads/master 
Pushing to git@github.com:CoderDream/iOS_Best_Practice.git
remote: error: GH001: Large files detected. You may want to try Git Large File Storage - https://git-lfs.github.com.        
remote: error: Trace: aada04fa77aa1a6d9b754290f6ca0b18        
remote: error: See http://git.io/iEPt8g for more information.        
remote: error: File MapDemo/Pods/AMap3DMap/MAMapKit.framework/MAMapKit is 137.41 MB; this exceeds GitHub's file size limit of 100.00 MB        
To github.com:CoderDream/iOS_Best_Practice.git
! [remote rejected] master -> master (pre-receive hook declined)
error: failed to push some refs to 'git@github.com:CoderDream/iOS_Best_Practice.git'
Completed with errors, see above
```
