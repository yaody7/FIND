//
//  RegisterViewController.m
//  FIND
//
//  Created by ydy on 2020/2/21.
//  Copyright © 2020 ydy. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppDelegate.h"
@interface RegisterViewController ()
{
    UITextField *username;
    UITextField *password;
    UITextField *contact;
    UIButton *Register;
}
@end

@implementation RegisterViewController

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
    //set contact
    y = 0.4 * self.view.frame.size.height;
    contact = [[UITextField alloc]initWithFrame:(CGRect)CGRectMake(x, y, width, height)];
    contact.placeholder = @"Telephone Number";
    [self.view addSubview:contact];
    //set login
    x = 0.05 * self.view.frame.size.width;
    y = 0.55 * self.view.frame.size.height;
    width = 0.9 * self.view.frame.size.width;
    height = 0.06 * self.view.frame.size.height;
    Register = [[UIButton alloc]initWithFrame:(CGRect)CGRectMake(x, y, width, height)];
    [Register setTitle:@"Register" forState:UIControlStateNormal];
    Register.backgroundColor = UIColor.greenColor;
    [Register addTarget:self action:@selector(doRegister) forControlEvents:UIControlEventTouchUpInside];
    [Register.layer setCornerRadius:12];
    Register.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:Register];
    self.title = @"Register";
}
//TODO set the APP's user
- (void)doRegister{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@:8001/api/register",app.ServerIP]];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    NSDictionary *dic = @{@"username": username.text, @"password": password.text, @"contact": contact.text};
    
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
                [self.navigationController popViewControllerAnimated:NO];
                AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
                User *tmp = [[User alloc]init];
                tmp.contact = dict[@"contact"];
                tmp.found = dict[@"found"];
                tmp.lost = dict[@"lost"];
                tmp.name = dict[@"name"];;
                tmp.reward = dict[@"reward"];
                tmp.succeed = dict[@"succeed"];
                app.user = tmp;
            }
            if([dict[@"status"] isEqualToString:@"fail"]){
                UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"FAIL" message:@"Duplicate username or telephone number" preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *comfirmAc = [UIAlertAction actionWithTitle:@"Confirm" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                }];
                [alertVC addAction:comfirmAc];
                [self presentViewController:alertVC animated:YES completion:nil];
                
            }
        }
    }];
    [dataTask resume];
}

@end
