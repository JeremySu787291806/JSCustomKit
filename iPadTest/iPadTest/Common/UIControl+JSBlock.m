//
//  UIControl+JSBlock.m
//  iPadTest
//
//  Created by JeremySu on 16/9/27.
//  Copyright © 2016年 Su. All rights reserved.
//

#import "UIControl+JSBlock.h"

@implementation UIControl (JSBlock)

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)clicked:(id)sender {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

@end
