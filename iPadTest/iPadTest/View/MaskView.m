//
//  MaskView.m
//  iPadTest
//
//  Created by JeremySu on 16/9/27.
//  Copyright © 2016年 Su. All rights reserved.
//

#import "MaskView.h"

@implementation MaskView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addTarget:self action:@selector(clickMask:) forControlEvents:UIControlEventTouchUpInside];
        
        UIViewController *vc = [[UIViewController alloc] init];
        vc.view.backgroundColor = [UIColor redColor];
        vc.title = @"Title";
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [self addSubview:vc.view];
    }
    return self;
}

- (void)clickMask:(id)sender {
    if (self.clickBlock) {
        self.clickBlock(1);
    }
}

- (void)dealloc {
    NSLog(@"-------------%s-------------", __func__);
}

@end
