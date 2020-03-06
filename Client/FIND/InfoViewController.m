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
#import "UISearchBarWithConfirm.h"
@interface InfoViewController ()<NSURLSessionDelegate, UISearchBarDelegate>
{
    InfoViewModel *model;
    UIView *rightView;
    UIButton *rightBtn;
    NSString *t;
}
@end

@implementation InfoViewController
- (instancetype)initWithType:(NSString *)type
{
    self = [super init];
    if (self) {
        self.type = type;
        self.title = type;
        self->t = @"";
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
       //         self->model.info = [[NSMutableArray alloc]init];
                self->model.backup = [[NSMutableArray alloc]init];
                for (int i = 0; i < tmp.count; i++){
                    if([((NSDictionary *)[tmp objectAtIndex:i])[@"type"] isEqualToString:self.type]){
                   //     [self->model.info addObject:[tmp objectAtIndex:i]];
                        [self->model.backup addObject:[tmp objectAtIndex:i]];
                        self->model.info = self->model.backup;
                    }
                }
                //set datasource & delegate
                self->model.table = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
                [self->model.table setDataSource:self->model];
                [self->model.table setDelegate:self->model];
                
                //set UIRefreshControl
                UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
                refreshControl.tintColor = [UIColor grayColor];
                refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"Loading..."];
                [refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
                self->model.table.refreshControl = refreshControl;
                //set SearchBar
                self.search = [[UIView alloc]initWithFrame:(CGRect)CGRectMake(0, 0, self.view.frame.size.width, 0.05 * self.view.frame.size.height)];
      //          [self.search addTarget:self action:@selector(baga) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview:self.search];

                [self.view addSubview:self->model.table];
                self->model.table.tableHeaderView = self.search;
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


- (UIView *)search{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:(CGRect)CGRectMake(0, 0, 0.8 * width, 0.05 * height)];
    //add searchbar
    searchBar.barTintColor = UIColor.whiteColor;
    searchBar.placeholder = @"Please Enter Something";
    searchBar.backgroundImage = [[UIImage alloc]init];
    UITextField *searchField = [searchBar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius  = 13.0f;
        searchField.layer.borderColor   = [UIColor grayColor].CGColor;
        searchField.layer.borderWidth   = 1;
        searchField.layer.masksToBounds = YES;
    }
    searchBar.delegate = self;
    [_search addSubview:searchBar];
    //add searchBtn
    UIButton *searchBtn = [[UIButton alloc]initWithFrame:(CGRect)CGRectMake(0.8 * width, 0 , 0.2 * width, 0.05 * height)];
    [searchBtn setTitle:@"Search" forState:UIControlStateNormal];
    searchBtn.backgroundColor = UIColor.greenColor;
    [searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    [searchBtn.layer setCornerRadius:12];
    searchBtn.titleLabel.font = [UIFont systemFontOfSize: 20.0];
    [_search addSubview:searchBtn];
    return _search;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    t = searchText;
    if ([searchText length] == 0){
        self->model.info = self->model.backup;
        [self->model.table reloadData];
    }
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self searchClick];
}

- (void)refresh{
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
          //      self->model.info = [[NSMutableArray alloc]init];
                self->model.backup = [[NSMutableArray alloc]init];
                for (int i = 0; i < tmp.count; i++){
                    if([((NSDictionary *)[tmp objectAtIndex:i])[@"type"] isEqualToString:self.type]){
                     //   [self->model.info addObject:[tmp objectAtIndex:i]];
                        [self->model.backup addObject:[tmp objectAtIndex:i]];
                        self->model.info = self->model.backup;
                    }
                }
                [self->model.table reloadData];
                [self->model.table.refreshControl endRefreshing];
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
- (UIButton *)search1{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    UIButton *btn = [[UIButton alloc]initWithFrame:(CGRect)CGRectMake(0.8 * width, 0.005 * height, 0.2 *width, 0.04 * height)];
    [btn setTitle:@"Search" forState:UIControlStateNormal];
    btn.backgroundColor = UIColor.greenColor;
    [btn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    [btn.layer setCornerRadius:12];
    btn.titleLabel.font = [UIFont systemFontOfSize: 20.0];
    return btn;
}
- (UIButton *)cancel1{
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height;
    UIButton *btn = [[UIButton alloc]initWithFrame:(CGRect)CGRectMake(0.8 * width, 0, 0.2 *width, 0.05 * height)];
    [btn setTitleColor:[UIColor greenColor]forState:UIControlStateNormal];
    btn.backgroundColor = UIColor.whiteColor;
    [btn.layer setBorderColor:UIColor.greenColor.CGColor];
    [btn.layer setBorderWidth:1];
    [btn setTitle:@"Cancel" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [btn.layer setCornerRadius:12];
    btn.titleLabel.font = [UIFont systemFontOfSize: 20.0];
    return btn;
}
 */
- (void)searchClick{
    NSString *contain = self->t;
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < [self->model.backup count]; i++){
        NSDictionary *dict = (NSDictionary *)[self->model.backup objectAtIndex:i];
        NSString *tmp = (NSString *)dict[@"Thing"];
        if ([tmp containsString:contain]){
            [tempArray addObject:dict];
         }
    }
    self->model.info = tempArray;
    [self->model.table reloadData];
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
