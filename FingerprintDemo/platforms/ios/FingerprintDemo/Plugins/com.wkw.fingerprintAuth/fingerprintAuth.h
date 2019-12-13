//
//  testPlugin.h
//  
//
//  Created by admin on 2019/11/27.
//
#import <Cordova/CDV.h>

@interface fingerprintAuth : CDVPlugin {
        // Member variables go here.
}
@property(nonatomic,strong)CDVInvokedUrlCommand *myCommand;

- (void)isAvailable:(CDVInvokedUrlCommand*)command;
@end
