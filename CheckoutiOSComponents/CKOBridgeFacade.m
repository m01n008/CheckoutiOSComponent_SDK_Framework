// CKOBridgeFacade.m
#import "CKOBridgeFacade.h"
#import <CheckoutiOSComponents-Swift.h>

@implementation CKOBridgeFacade

+ (void)presentMainAutoAnimated:(BOOL)animated {
    dispatch_async(dispatch_get_main_queue(), ^{
        [CKOBridge presentMainAutoWithAnimated:animated config:nil];
    });
}

+ (void)presentMainAutoWithConfig:(NSDictionary * _Nullable)config animated:(BOOL)animated {
    dispatch_async(dispatch_get_main_queue(), ^{
        [CKOBridge presentMainAutoWithAnimated:animated config:config];
    });
}

+ (UIViewController *)makeMainViewController {
    __block UIViewController *vc = nil;
    dispatch_sync(dispatch_get_main_queue(), ^{
        vc = [CKOBridge makeMainViewController];
    });
    return vc;
}

+ (void)pushMainOn:(UINavigationController *)nav animated:(BOOL)animated config:(NSDictionary * _Nullable)config {
    dispatch_async(dispatch_get_main_queue(), ^{
        [CKOBridge pushMainOn:nav animated:animated config:config];
    });
}

+ (void)embedMainIn:(UIView *)container parent:(UIViewController *)parent config:(NSDictionary * _Nullable)config {
    dispatch_async(dispatch_get_main_queue(), ^{
        [CKOBridge embedMainIn:container parentViewController:parent config:config];
    });
}

@end
