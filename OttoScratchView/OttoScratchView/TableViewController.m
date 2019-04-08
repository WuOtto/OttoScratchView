//
//  TableViewController.m
//  OttoScratchView
//
//  Created by halo on 2019/4/8.
//  Copyright © 2019 otto. All rights reserved.
//

#import "TableViewController.h"
#import "ViewController.h"
#import "MainViewController.h"

@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0){
        cell.textLabel.text = @"纯代码实现";
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"Xib实现";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0){
        [self.navigationController pushViewController:[ViewController new] animated:YES];
    }else if (indexPath.row == 1){
        [self.navigationController pushViewController:[MainViewController new] animated:YES];
    }
}

@end
