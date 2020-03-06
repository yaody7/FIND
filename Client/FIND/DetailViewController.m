//
//  DetailViewController.m
//  FIND
//
//  Created by ydy on 2020/3/2.
//  Copyright © 2020 ydy. All rights reserved.
//
#define X_OFFSET 0.05 * self.view.frame.size.width
#define WIDTH 0.9 * self.view.frame.size.width
#import "PostViewController.h"
#import "UITextViewWithPlaceholder.h"
#import "AppDelegate.h"
#import "QCloud.h"
#import "DetailViewController.h"

@interface DetailViewController ()<NSURLSessionDelegate>
{
    
}
@end

@implementation DetailViewController
- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.info = dict;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //add subview
    [self.view addSubview:self.thing];
    [self.view addSubview:self.image];
    [self.view addSubview:self.contact];
    [self.view addSubview:self.detail];
    //set title
    self.title = @"DETAIL";
    //set backgroundColor
    self.view.backgroundColor = UIColor.whiteColor;
    // Do any additional setup after loading the view.
}

- (UIView *)thing{
    CGFloat yOffset = 0.03 * self.view.frame.size.height;
    CGFloat width = self.view.frame.size.width - 2 * X_OFFSET;
    CGFloat height = 0.2 * self.view.frame.size.height / 3;
    _thing = [[UIView alloc]initWithFrame:(CGRect)CGRectMake(X_OFFSET, yOffset, width, height)];
    //set title
    UILabel *t = [[UILabel alloc]initWithFrame:(CGRect)CGRectMake(0, 0, width, 25)];
    t.text=@"THING:";
    t.font = [UIFont systemFontOfSize:25 weight:UIFontWeightBold];
    [_thing addSubview:t];
    //set textfield
    yOffset = 0.15 * self.view.frame.size.height;
    width = self.view.frame.size.width - X_OFFSET;
    height = 30;
    UILabel *tmp = [[UILabel alloc]initWithFrame:(CGRect)CGRectMake(0, 35, width, 35)];
    tmp.font = [UIFont systemFontOfSize:25];
    tmp.text = self.info[@"Thing"];
    [_thing addSubview:tmp];
    return _thing;
}

- (UIView *)image{
    CGFloat yOffset = 0.13 * self.view.frame.size.height;
    CGFloat width = self.view.frame.size.width - 2 * X_OFFSET;
    CGFloat height = 3 * width / 4 + 35 ;
    _image = [[UIView alloc]initWithFrame:(CGRect)CGRectMake(X_OFFSET, yOffset, width, height)];
    //set title
    UILabel *i = [[UILabel alloc]initWithFrame:(CGRect)CGRectMake(0, 0, width, 25)];
    i.text=@"PICTURE:";
    i.font = [UIFont systemFontOfSize:25 weight:UIFontWeightBold];
    [_image addSubview:i];
    //set image
    UIImageView *tmp = [[UIImageView alloc]initWithFrame:(CGRect)CGRectMake(0, 35, width, 3 * width / 4)];
    tmp.image = [UIImage imageNamed:@"loading.png"];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [cachePath stringByAppendingPathComponent:self.info[@"Picture"]];
    if ([fileManager fileExistsAtPath:filePath]){
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        tmp.image = [UIImage imageWithData:data];
    }else{
        tmp.image = [UIImage imageNamed:@"loading.png"];
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                           delegate: self
                                                                      delegateQueue: [[NSOperationQueue alloc]init]];
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        NSString *imageURL = [NSString stringWithFormat:@"%@%@",app.QCloudIP,self.info[@"Picture"]];
        NSURL *url = [NSURL URLWithString:imageURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSessionDataTask *dataTask = [delegateFreeSession dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSLog(@"%@",[UIImage imageWithData:[NSData dataWithContentsOfURL:url]]);
                tmp.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                [UIImagePNGRepresentation(tmp.image) writeToFile:filePath atomically:YES];
            });
        }];
        [dataTask resume];
    }
    [_image addSubview:tmp];
    return _image;
}

- (UIView *)detail{
    CGFloat yOffset = 0.62 * self.view.frame.size.height;
    CGFloat width = self.view.frame.size.width - 2 * X_OFFSET;
    CGFloat height = 3 * width / 4 + 35 ;
    _detail = [[UIView alloc]initWithFrame:(CGRect)CGRectMake(X_OFFSET, yOffset, width, height)];
    //set title
    UILabel *d = [[UILabel alloc]initWithFrame:(CGRect)CGRectMake(0, 0, width, 25)];
    d.text=@"DETAIL:";
    d.font = [UIFont systemFontOfSize:25 weight:UIFontWeightBold];
    [_detail addSubview:d];
    //set textview
    UITextView *textView = [[UITextView alloc]initWithFrame:(CGRect)CGRectMake(0, 35, width, height - 35)];
    textView.font = [UIFont systemFontOfSize:25];
    textView.text = self.info[@"Detail"];
    [_detail addSubview:textView];
    return _detail;
}

- (UIView *)contact{
    CGFloat yOffset = 0.5 * self.view.frame.size.height;
    CGFloat width = self.view.frame.size.width - 2 * X_OFFSET;
    _contact = [[UIView alloc]initWithFrame:(CGRect)CGRectMake(X_OFFSET, yOffset, width, 40)];
    //set title
    UILabel *d = [[UILabel alloc]initWithFrame:(CGRect)CGRectMake(0, 0, width, 25)];
    d.text=@"CONTACT:";
    d.font = [UIFont systemFontOfSize:25 weight:UIFontWeightBold];
    [_contact addSubview:d];
    //set textview
    UILabel *textView = [[UILabel alloc]initWithFrame:(CGRect)CGRectMake(0, 35, width, 40)];
    textView.font = [UIFont systemFontOfSize:25];
    textView.text = self.info[@"contact"];
    [_contact addSubview:textView];
    return _contact;
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
