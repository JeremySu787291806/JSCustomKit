//
//  PopoverMenuViewController.h
//  iPadTest
//
//  Created by JeremySu on 16/9/26.
//  Copyright © 2016年 Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopoverMenuViewController : UIViewController

@property (nonatomic, copy) void (^didSelectBlock)();

@end
