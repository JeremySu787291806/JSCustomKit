//
//  PresentViewController.h
//  iPadTest
//
//  Created by JeremySu on 16/9/27.
//  Copyright © 2016年 Su. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PresentDirectionFromBottom = 0,
    PresentDirectionFromUp,
    PresentDirectionFromLeft,
    PresentDirectionFromRight
}PresentDirection;

@interface PresentInfo : NSObject

@property (nonatomic, assign) CGFloat cAlpha;               //背景透明值
@property (nonatomic, strong) UIView *contentView;          //内容view
@property (nonatomic, assign) CGFloat duration;             //动画时间
@property (nonatomic, assign) PresentDirection direction;   //动画方向

@end

@interface PresentViewController : UIViewController

@property (nonatomic, copy) PresentInfo* (^blockPreInit)(__weak PresentViewController *aVc);
- (void)showFromParentViewController:(UIViewController *)parentVC coverNav:(BOOL)coverNav;
- (void)hide;

@end
