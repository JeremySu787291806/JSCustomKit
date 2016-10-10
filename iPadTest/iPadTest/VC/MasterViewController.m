//
//  MasterViewController.m
//  iPadTest
//
//  Created by JeremySu on 16/9/25.
//  Copyright © 2016年 Su. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"

@interface MasterViewController () <UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *dataSourceList;

@end

@implementation MasterViewController

- (NSMutableArray *)dataSourceList {
    if (_dataSourceList==nil) {
        NSDictionary *dict1 = @{@"red":[UIColor redColor]};
        NSDictionary *dict2 = @{@"green":[UIColor greenColor]};
        NSDictionary *dict3 = @{@"black":[UIColor blackColor]};
        _dataSourceList = [[NSMutableArray alloc] initWithObjects:dict1,dict2,dict3, nil];
    }
    return _dataSourceList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    //设置主控制器Master的导航栏和按钮
    self.navigationItem.title = @"Master";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                          target:self
                                                                                          action:nil];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                          target:self
                                                                                          action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    NSDictionary *dict = self.dataSourceList[indexPath.row];
    cell.textLabel.text = dict.allKeys[0];
    return cell;
}

#pragma mark -<UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UINavigationController *detailNAV = [self.splitViewController.viewControllers lastObject];
    DetailViewController *detatilVC = (DetailViewController*)[detailNAV topViewController];
    
    NSDictionary *dict = self.dataSourceList[indexPath.row];
    UIColor *color = dict.allValues[0];
    detatilVC.view.backgroundColor = color;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.splitViewController dismissViewControllerAnimated:YES completion:nil];
    });
}

@end
