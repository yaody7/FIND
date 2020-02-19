//
//  ViewController.m
//  FIND
//
//  Created by ydy on 2020/2/18.
//  Copyright © 2020 ydy. All rights reserved.
//

#import "FoundViewController.h"
#import "InfoViewModel.h"

@interface FoundViewController ()
{
    InfoViewModel *model;
    UITableView *table;
}
@end

@implementation FoundViewController

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
    self.title = @"FOUND";
    
    
}


@end
