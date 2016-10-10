//
//  ViewController.m
//  iPadTest
//
//  Created by JeremySu on 16/9/22.
//  Copyright © 2016年 Su. All rights reserved.
//

#import "ViewController.h"

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "PresentViewController.h"

#import "MaskView.h"
#import "PopoverMenuViewController.h"

@interface ViewController () <UISplitViewControllerDelegate>

@property (nonatomic, strong) UISplitViewController *splitViewController;
@property (nonatomic, strong) UIPopoverController *popover;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"ViewController";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"Split"
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:self
                                                                 action:@selector(goSplit:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:@"Popover"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(goPopover:)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
    view1.backgroundColor = [UIColor redColor];
    view1.center = self.view.center;
    [self.view addSubview:view1];
    
    UIViewController *vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor yellowColor];
    vc1.title = @"yellow";
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc1];
    vc1.view.frame = view1.bounds;
    nav.view.frame = view1.bounds;
    [view1 addSubview:nav.view];
    [self addChildViewController:nav];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(3,
                                                            vc1.view.bounds.size.height-10,
                                                            vc1.view.bounds.size.width-3*2,
                                                            4)];
    line.backgroundColor = [UIColor greenColor];
    //line.center = vc1.view.center;
    [vc1.view addSubview:line];
    
    /*
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((self.view.frame.size.width-60)/2, (self.view.frame.size.height-40)/2, 60, 40);
    [button setTitle:@"Present" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [button addTarget:self action:@selector(presentAction:) forControlEvents:UIControlEventTouchUpInside];
    button.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;;
    [self.view addSubview:button];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentAction:(id)sender {
    PresentViewController *vc = [[PresentViewController alloc] init];
    vc.blockPreInit = ^(__weak PresentViewController *aVc) {
        PresentInfo *info = [PresentInfo new];
        info.cAlpha = 0.13;
        //info.direction = PresentDirectionFromRight;
        
        MaskView *view = [[MaskView alloc] initWithFrame:CGRectMake(0, 0, 500, 500)];
        view.clickBlock = ^(NSInteger tag) {
            [aVc hide];
        };
        info.contentView = view;
        
        return info;
    };
    [vc showFromParentViewController:self coverNav:YES];
}

- (void)goPopover:(id)sender {
    __weak typeof(self) weakSelf = self;
    PopoverMenuViewController *vc = [[PopoverMenuViewController alloc] init];
    vc.didSelectBlock = ^() {
        __block typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.popover dismissPopoverAnimated:YES];
    };
    
    self.popover = [[UIPopoverController alloc] initWithContentViewController:vc];
    self.popover.popoverContentSize=CGSizeMake(320, 200);
    
    [self.popover presentPopoverFromRect:self.view.bounds
                                  inView:self.view
                permittedArrowDirections:0
                                animated:YES];
    
    /*
    [self.popover presentPopoverFromBarButtonItem:self.navigationItem.leftBarButtonItem
                         permittedArrowDirections:0
                                         animated:YES];
     */
}

- (void)goSplit:(id)sender {
    MasterViewController *MasterVC = [[MasterViewController alloc]init];
    UINavigationController *MasterNavigationController = [[UINavigationController alloc] initWithRootViewController:MasterVC];
    
    DetailViewController *DetailVC = [[DetailViewController alloc]init];
    UINavigationController *DetailNavigationController = [[UINavigationController alloc]initWithRootViewController:DetailVC];
    
    //创建分割控制器
    self.splitViewController = [[UISplitViewController alloc]init];
    self.splitViewController.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryHidden;
    self.splitViewController.viewControllers = @[MasterNavigationController,DetailNavigationController];
    self.splitViewController.delegate = self;
    
    [self presentViewController:self.splitViewController animated:YES completion:nil];
}

#pragma mark - UISplitViewControllerDelegate methods
//主控制器将要隐藏时触发的方法
- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc {
    barButtonItem.title = @"Master";
    //master将要隐藏时，给detail设置一个返回按钮
    UINavigationController *Nav = [self.splitViewController.viewControllers lastObject];
    DetailViewController *Detail = (DetailViewController *)[Nav topViewController];
    Detail.navigationItem.leftBarButtonItem = barButtonItem;
}

//开始时取消二级控制器,只显示详细控制器
- (BOOL)splitViewController:(UISplitViewController *)splitViewController
collapseSecondaryViewController:(UIViewController *)secondaryViewController
  ontoPrimaryViewController:(UIViewController *)primaryViewController {
    return YES;
}

//主控制器将要显示时触发的方法
- (void)splitViewController:(UISplitViewController *)sender
     willShowViewController:(UIViewController *)master
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    //master将要显示时,取消detail的返回按钮
    UINavigationController *Nav = [self.splitViewController.viewControllers lastObject];
    DetailViewController *Detail = (DetailViewController *)[Nav topViewController];
    Detail.navigationItem.leftBarButtonItem = nil;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    if (self.popover.popoverVisible) {
        [self.popover presentPopoverFromRect:self.view.bounds
                                      inView:self.view
                    permittedArrowDirections:0
                                    animated:YES];
    }
}

@end
