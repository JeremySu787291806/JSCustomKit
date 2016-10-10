//
//  PopoverMenuViewController.m
//  iPadTest
//
//  Created by JeremySu on 16/9/26.
//  Copyright © 2016年 Su. All rights reserved.
//

#import "PopoverMenuViewController.h"

@interface PopoverMenuViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray *menus;
@property (nonatomic, strong) UITableView *aTableView;

@end

@implementation PopoverMenuViewController

- (UITableView *)aTableView {
    if (_aTableView == nil) {
        _aTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _aTableView.delegate = self;
        _aTableView.dataSource = self;
    }
    return _aTableView;
}

- (NSArray *)menus {
    if (_menus == nil) {
        _menus = @[@"列表1",@"列表2",@"列表3",@"列表4",@"列表11",@"列表12",@"列表13",@"列表14"];
    }
    return _menus;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //CGFloat maxH = MIN(480, self.menus.count*44);
    //self.preferredContentSize = CGSizeMake(320, maxH);
    [self.view addSubview:self.aTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.aTableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menus count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text = self.menus[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.didSelectBlock) {
        self.didSelectBlock();
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    NSLog(@"--------Orientation:%ld--------", fromInterfaceOrientation);
}

@end
