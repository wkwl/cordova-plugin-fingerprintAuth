cordova-plugin-fingerprintAuth是提供vue开发以及h5混合开发app的插件，主要功能是在iOS平台使用指纹识别授权功能。

使用方式：
cd xxx(你的项目路径)

cordova plugin add xxx(插件路径，可以将插件下载到本地安装)

'''
<script type="text/javascript" charset="utf-8" src="cordova.js"></script>
<script type="text/javascript" charset="utf-8">

function fingerprintAuthSdkPlugin() {
fingerprintAuth.isAvailable(success,error);
}
function success(msg){
alert(msg);
}
function error(msg){
alert(msg);
}
</script>
'''
