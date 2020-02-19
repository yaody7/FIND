//
//  LoginViewController.m
//  FIND
//
//  Created by ydy on 2020/2/19.
//  Copyright © 2020 ydy. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
{
    UITextField *username;
    UITextField *password;
    UIButton *login;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //set username
    CGFloat x = 0.15 * self.view.frame.size.width;
    CGFloat y = 0.2 * self.view.frame.size.height;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = 0.1 * self.view.frame.size.height;
    username = [[UITextField alloc]initWithFrame:(CGRect)CGRectMake(x, y, width, height)];
    username.placeholder = @"Username";
    [self.view addSubview:username];
    //set password
    y = 0.3 * self.view.frame.size.height;
    password = [[UITextField alloc]initWithFrame:(CGRect)CGRectMake(x, y, width, height)];
    password.placeholder = @"Password";
    [self.view addSubview:password];
    //set login
    x = 0.05 * self.view.frame.size.width;
    y = 0.45 * self.view.frame.size.height;
    width = 0.9 * self.view.frame.size.width;
    height = 0.06 * self.view.frame.size.height;
    login = [[UIButton alloc]initWithFrame:(CGRect)CGRectMake(x, y, width, height)];
    [login setTitle:@"Login" forState:UIControlStateNormal];
    login.backgroundColor = UIColor.greenColor;
    [login addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:login];
}
//TODO set the APP's user
- (void)doLogin{
    
}
@end
