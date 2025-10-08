//
//  CKOBridgeFacade.h
//  CheckoutiOSComponents
//
//  Created by Moin Khan on 07/10/2025.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CKOBridgeFacade : NSObject

+ (UIViewController *)makeMainViewController;
+ (void)presentMainAutoAnimated:(BOOL)animated;
+ (void)presentMainAutoWithConfig:(NSDictionary * _Nullable)config animated:(BOOL)animated;
+ (void)pushMainOn:(UINavigationController *)nav
          animated:(BOOL)animated
            config:(NSDictionary * _Nullable)config;
+ (void)embedMainIn:(UIView *)container
             parent:(UIViewController *)parent
             config:(NSDictionary * _Nullable)config;

@end

NS_ASSUME_NONNULL_END
