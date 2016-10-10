//
//  PresentViewController.m
//  iPadTest
//
//  Created by JeremySu on 16/9/27.
//  Copyright © 2016年 Su. All rights reserved.
//

#import "PresentViewController.h"

@implementation PresentInfo

@end

@interface PresentViewController ()

@property (nonatomic, strong) PresentInfo *info;

@end

@implementation PresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.info = self.blockPreInit ? self.blockPreInit(self) : nil;
    
    NSAssert(self.info!=nil, @"PresentInfo最好初始化对象值");
    
    [self.view setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:self.info ? self.info.cAlpha : 0.15]];
    
    if (self.info && self.info.contentView) {
        CGPoint center = self.view.center;
        if (self.info.direction==PresentDirectionFromBottom) {
            center.y = self.view.bounds.size.height + self.info.contentView.bounds.size.height/2;
        } else if (self.info.direction==PresentDirectionFromLeft) {
            center.x = -self.info.contentView.bounds.size.width/2;
        } else if (self.info.direction==PresentDirectionFromRight) {
            center.x = self.view.bounds.size.width + self.info.contentView.bounds.size.width/2;
        } else if (self.info.direction==PresentDirectionFromUp) {
            center.y = -self.info.contentView.bounds.size.height/2;
        }
        self.info.contentView.center = center;
        self.info.contentView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        [self.view addSubview:self.info.contentView];
        
        [UIView animateWithDuration:0.3 animations:^{
            self.info.contentView.center = self.view.center;
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"-------------%s-------------", __func__);
}

- (void)showFromParentViewController:(UIViewController *)parentVC coverNav:(BOOL)coverNav {
    if (parentVC) {
        if (parentVC.navigationController && coverNav) {
            [parentVC.navigationController.view addSubview:self.view];
            [parentVC.navigationController addChildViewController:self];
        } else {
            [parentVC.view addSubview:self.view];
            [parentVC addChildViewController:self];
        }
    }
}

- (void)hide {
    if (self.info && self.info.contentView) {
        CGPoint center = self.view.center;
        if (self.info.direction==PresentDirectionFromBottom) {
            center.y = self.view.bounds.size.height + self.info.contentView.bounds.size.height/2;
        } else if (self.info.direction==PresentDirectionFromLeft) {
            center.x = self.view.bounds.size.width + self.info.contentView.bounds.size.width/2;
        } else if (self.info.direction==PresentDirectionFromRight) {
            center.x = -self.info.contentView.bounds.size.width/2;
        } else if (self.info.direction==PresentDirectionFromUp) {
            center.y = -self.info.contentView.bounds.size.height/2;
        }
        [UIView animateWithDuration:0.3 animations:^{
            self.info.contentView.center = center;
        } completion:^(BOOL finished) {
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
        }];
    }
}

@end
