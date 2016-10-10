//
//  MaskView.h
//  iPadTest
//
//  Created by JeremySu on 16/9/27.
//  Copyright © 2016年 Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaskView : UIControl

@property (nonatomic, copy) void(^clickBlock)(NSInteger tag);

@end
