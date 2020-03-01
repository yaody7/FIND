//
//  InfoViewController.m
//  FIND
//
//  Created by ydy on 2020/2/18.
//  Copyright © 2020 ydy. All rights reserved.
//

#import "InfoViewController.h"
#import "InfoViewModel.h"
#import "PostViewController.h"

@interface InfoViewController ()
{
    InfoViewModel *model;
    UITableView *table;
    UIView *rightView;
    UIButton *rightBtn;
}
@end

@implementation InfoViewController

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
    
    //PostBtn
    rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat viewLength = self.navigationController.navigationBar.frame.size.height;
    CGFloat buttonOffset = (viewLength - 30) / 2;
    rightBtn.frame = CGRectMake(buttonOffset, buttonOffset, 30, 30);
    [rightBtn setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
    /*点击变色效果不好，待改进
    [rightBtn addTarget:self action:@selector(turnGray) forControlEvents:UIControlEventTouchDown];
    [rightBtn addTarget:self action:@selector(turnWhite) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn addTarget:self action:@selector(turnWhite) forControlEvents:UIControlEventTouchDragExit];
    */
    [rightBtn addTarget:self action:@selector(post) forControlEvents:UIControlEventTouchUpInside];
    rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewLength, viewLength)];
    [rightView addSubview:rightBtn];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
}
- (void)post{
 //   [self presentViewController:[[PostViewController alloc]init] animated:YES completion:nil];
    PostViewController *tmp = [[PostViewController alloc]init];
    tmp.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tmp animated:YES];
}
- (void)dealloc
{
    [table setDelegate:nil];
    [table setDataSource:nil];
}
/*
点击变色效果不好，待改进
- (void)turnGray{
    self->rightView.backgroundColor = UIColor.grayColor;
}
- (void)turnWhite{
    self->rightView.backgroundColor = UIColor.whiteColor;
}
 */

@end
