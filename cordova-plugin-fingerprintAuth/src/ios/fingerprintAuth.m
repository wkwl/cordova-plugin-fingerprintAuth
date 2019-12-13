/********* fingerprintAuth.m Cordova Plugin Implementation *******/

#import "fingerprintAuth.h"
#import "TouchIDManager.h"

@implementation fingerprintAuth

- (void)isAvailable:(CDVInvokedUrlCommand*)command
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter]removeObserver:self];
        self.myCommand = command;
        [self setupNotification];
        [TouchIDManager validateTouchID];
    });
}
- (void)callbackAction:(NSString *)String {
    __block NSString *str = String;
    [self.commandDelegate runInBackground:^{
        CDVPluginResult *pluginResult = nil;
        if ([str isEqualToString:ValidateTouchIDSuccess]) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"指纹识别授权成功"];
        }else if ([str isEqualToString:ValidateTouchIDNotAvailable]){
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"设备指纹识别不可用"];
        }else if ([str isEqualToString:ValidateTouchIDNotEnrolled]){
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"设备未设置指纹"];
        }else if ([str isEqualToString:ValidateTouchIDAuthenticationFailed]){
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"指纹识别授权失败"];
        }else{
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"取消"];
        }

        NSLog(@"999999%@",str);
        [self.commandDelegate sendPluginResult:pluginResult callbackId:self.myCommand.callbackId];

    }];
}

- (void)setupNotification
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(actionDidReceiveValidateTouchIDSuccess) name:ValidateTouchIDSuccess object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(actionDidReceiveValidateTouchIDNotAvailable) name:ValidateTouchIDNotAvailable object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(actionDidReceiveValidateTouchIDNotEnrolled) name:ValidateTouchIDNotEnrolled object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(actionDidReceiveValidateTouchIDAuthenticationFailed) name:ValidateTouchIDAuthenticationFailed object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(actionDidReceiveValidateTouchIDCancel) name:ValidateTouchIDCancel object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(actionTouchIDLockout) name:ValidateTouchIDLockout object:nil];
}
/*
 * 授权成功
 */
- (void)actionDidReceiveValidateTouchIDSuccess
{
    NSLog(@"%s",__func__);
    [self callbackAction:ValidateTouchIDSuccess];
}
/*
 * 设备指纹不可用
 */
- (void)actionDidReceiveValidateTouchIDNotAvailable
{
    NSLog(@"%s",__func__);
    [self callbackAction:ValidateTouchIDNotAvailable];
}
/*
 * 设备未设置指纹
 */
- (void)actionDidReceiveValidateTouchIDNotEnrolled
{
    NSLog(@"%s",__func__);
    [self callbackAction:ValidateTouchIDNotEnrolled];
}
/*
 * 授权失败
 */
- (void)actionDidReceiveValidateTouchIDAuthenticationFailed
{
    NSLog(@"%s",__func__);
    [self callbackAction:ValidateTouchIDAuthenticationFailed];
}
/*
 * 取消按钮
 */
- (void)actionDidReceiveValidateTouchIDCancel
{
    NSLog(@"%s",__func__);
    [self callbackAction:ValidateTouchIDCancel];
}
/*
 * 指纹设备被锁定
 */

- (void)actionTouchIDLockout
{
    NSLog(@"%s",__func__);
        //    [self callbackAction:ValidateTouchIDLockout];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
