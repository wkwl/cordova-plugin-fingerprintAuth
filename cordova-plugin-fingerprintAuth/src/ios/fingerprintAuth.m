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
    __weak fingerprintAuth *weakSelf = self;
    [self.commandDelegate runInBackground:^{
        CDVPluginResult *pluginResult = nil;
        NSDictionary *dic ;
        if ([str isEqualToString:ValidateTouchIDSuccess]) {
            dic = @{@"success":@(YES),@"description":@"指纹识别成功",@"code":@"0"};
        }else if ([str isEqualToString:ValidateTouchIDNotAvailable]){
            dic = @{@"success":@(NO),@"description":@"该设备指纹识别不可用",@"code":@"1"};
        }else if ([str isEqualToString:ValidateTouchIDNotEnrolled]){
            dic = @{@"success":@(NO),@"description":@"设备未设置指纹",@"code":@"2"};
        }else if ([str isEqualToString:ValidateTouchIDAuthenticationFailed]){
            dic = @{@"success":@(NO),@"description":@"指纹识别失败",@"code":@"3"};
        }else {
            dic = @{@"success":@(NO),@"description":@"取消",@"code":@"4"};
        }
        if ([str isEqualToString:ValidateTouchIDSuccess]) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:dic];
        }else{
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsDictionary:dic];
        }

//        NSLog(@"999999%@",str);
        [weakSelf.commandDelegate sendPluginResult:pluginResult callbackId:weakSelf.myCommand.callbackId];
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
