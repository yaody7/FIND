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
#import "AppDelegate.h"
@interface InfoViewController ()<NSURLSessionDelegate>
{
    InfoViewModel *model;
    UIView *rightView;
    UIButton *rightBtn;
}
@end

@implementation InfoViewController
- (instancetype)initWithType:(NSString *)type
{
    self = [super init];
    if (self) {
        self.type = type;
        self.title = type;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //init tableView
    [self getInfo];
}

- (void)post{
 //   [self presentViewController:[[PostViewController alloc]init] animated:YES completion:nil];
    PostViewController *tmp = [[PostViewController alloc]init];
    tmp.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tmp animated:YES];
}
- (void)dealloc
{
    [self->model.table setDelegate:nil];
    [self->model.table setDataSource:nil];
}

- (void) getInfo {
    __block NSArray *tmp;
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:8001/api/getPost",app.ServerIP]];
    NSURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    NSURLSessionTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error == nil) {
     //      NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if([dict[@"status"] isEqualToString:@"success"]){
                tmp = [[NSArray alloc]initWithArray:dict[@"items"]];
                //init viewModel
                self->model = [[InfoViewModel alloc]init];
                [self->model addObserver:self forKeyPath:@"vc" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
                self->model.info = [[NSMutableArray alloc]init];
                for (int i = 0; i < tmp.count; i++){
                    if([((NSDictionary *)[tmp objectAtIndex:i])[@"type"] isEqualToString:self.type])
                        [self->model.info addObject:[tmp objectAtIndex:i]];
                }
                //set datasource & delegate
                self->model.table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
                [self->model.table setDataSource:self->model];
                [self->model.table setDelegate:self->model];
                [self.view addSubview:self->model.table];
                self->model.table.backgroundColor=[UIColor whiteColor];
                
                //PostBtn
                self->rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                CGFloat viewLength = self.navigationController.navigationBar.frame.size.height;
                CGFloat buttonOffset = (viewLength - 30) / 2;
                self->rightBtn.frame = CGRectMake(buttonOffset, buttonOffset, 30, 30);
                [self->rightBtn setImage:[UIImage imageNamed:@"add.png"] forState:UIControlStateNormal];
                /*点击变色效果不好，待改进
                [rightBtn addTarget:self action:@selector(turnGray) forControlEvents:UIControlEventTouchDown];
                [rightBtn addTarget:self action:@selector(turnWhite) forControlEvents:UIControlEventTouchUpInside];
                [rightBtn addTarget:self action:@selector(turnWhite) forControlEvents:UIControlEventTouchDragExit];
                */
                [self->rightBtn addTarget:self action:@selector(post) forControlEvents:UIControlEventTouchUpInside];
                self->rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewLength, viewLength)];
                [self->rightView addSubview:self->rightBtn];
                UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:self->rightView];
                self.navigationItem.rightBarButtonItem = rightBarBtn;
            } else{
                NSLog(@"Fail");
            }
        }
    }];
    [dataTask resume];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (change[@"new"] != nil){
        [self.navigationController pushViewController:change[@"new"] animated:YES];
    }
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
