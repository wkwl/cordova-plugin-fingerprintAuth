cordova-plugin-fingerprintAuth是提供vue开发以及h5混合开发app的插件，主要功能是在iOS平台使用指纹识别授权功能。

使用方式：
cd xxx(你的项目路径)
返回内容：例：msg = {"success":true,"description":"指纹识别成功","code":"0"};
code:0 //指纹识别成功
code:1//该设备指纹识别不可用
code:2//设备未设置指纹
code:3//指纹识别失败
code:4//取消
cordova plugin add xxx(插件路径，可以将插件下载到本地安装，也可以cordova plugin add https://github.com/wkwl/cordova-plugin-fingerprintAuth.git)

```
<script type="text/javascript" charset="utf-8" src="cordova.js"></script>
<script type="text/javascript" charset="utf-8">

function fingerprintAuthSdkPlugin() {
fingerprintAuth.isAvailable("",success,error);
}
function success(msg){
alert(msg);
}
function error(msg){
alert(msg);
}
</script>
```
