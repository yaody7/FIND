//
//  LostViewController.m
//  FIND
//
//  Created by ydy on 2020/2/18.
//  Copyright © 2020 ydy. All rights reserved.
//

#import "LostViewController.h"
#import "InfoViewModel.h"
@interface LostViewController ()
{
    InfoViewModel *model;
    UITableView *table;
}
@end

@implementation LostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //init tableView
    table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    //init viewModel
    model = [[InfoViewModel alloc]init];
    //set datasource & delegate
    [table setDataSource:model];
    [table setDelegate:model];
    [self.view addSubview:table];
    table.backgroundColor=[UIColor whiteColor];
    //set title
    self.title = @"LOST";
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
