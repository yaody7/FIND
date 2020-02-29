//
//  LoginViewController.m
//  FIND
//
//  Created by ydy on 2020/2/19.
//  Copyright © 2020 ydy. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "User.h"
#import "RegisterViewController.h"
@interface LoginViewController ()
{
    UITextField *username;
    UITextField *password;
    UIButton *login;
    UIButton *regi;
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
    [password setSecureTextEntry:YES];
    [self.view addSubview:password];
    //set login
    x = 0.05 * self.view.frame.size.width;
    y = 0.45 * self.view.frame.size.height;
    width = 0.43 * self.view.frame.size.width;
    height = 0.06 * self.view.frame.size.height;
    login = [[UIButton alloc]initWithFrame:(CGRect)CGRectMake(x, y, width, height)];
    [login setTitle:@"Login" forState:UIControlStateNormal];
    login.backgroundColor = UIColor.greenColor;
    [login addTarget:self action:@selector(doLogin) forControlEvents:UIControlEventTouchUpInside];
    [login.layer setCornerRadius:12];
    login.titleLabel.font = [UIFont systemFontOfSize: 20.0];
    [self.view addSubview:login];
    //set register
    x = 0.52 * self.view.frame.size.width;
    y = 0.45 * self.view.frame.size.height;
    width = 0.43 * self.view.frame.size.width;
    height = 0.06 * self.view.frame.size.height;
    regi = [[UIButton alloc]initWithFrame:(CGRect)CGRectMake(x, y, width, height)];
    [regi setTitle:@"Register" forState:UIControlStateNormal];
    [regi setTitleColor:[UIColor greenColor]forState:UIControlStateNormal];
    regi.backgroundColor = UIColor.whiteColor;
    [regi.layer setBorderColor:UIColor.greenColor.CGColor];
    [regi.layer setBorderWidth:1];
    [regi addTarget:self action:@selector(jumpRegister) forControlEvents:UIControlEventTouchUpInside];
    [regi.layer setCornerRadius:12];
    regi.titleLabel.font = [UIFont systemFontOfSize: 20.0];
    [self.view addSubview:regi];
    self.title = @"Login";
}
//TODO set the APP's user
- (void)doLogin{
    //get the User
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.103:8001/api/login"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    NSDictionary *dic = @{@"username": username.text, @"password": password.text};
    
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [urlRequest setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error == nil) {
     //      NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if([dict[@"status"] isEqualToString:@"success"]){
                //set User
                AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                User *tmp = [[User alloc]init];
                tmp.contact = dict[@"contact"];
                tmp.found = dict[@"found"];
                tmp.lost = dict[@"lost"];
                tmp.name = dict[@"name"];;
                tmp.reward = dict[@"reward"];
                tmp.succeed = dict[@"succeed"];
                tmp.portraitURL = dict[@"portrait"];
                app.user = tmp;
            }
            if([dict[@"status"] isEqualToString:@"fail"]){
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"FAIL" message:@"Wrong username or password" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *comfirmAc = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alertVC addAction:comfirmAc];
                [self presentViewController:alertVC animated:YES completion:nil];

            }
        }
    }];
    [dataTask resume];
}
- (void)jumpRegister{
    RegisterViewController *rec = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:rec animated:YES];
}
@end
