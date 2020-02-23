//
//  MeViewController.m
//  FIND
//
//  Created by ydy on 2020/2/19.
//  Copyright © 2020 ydy. All rights reserved.
//

#import "MeViewController.h"
#import "AppDelegate.h"
#import "Masonry.h"
@interface MeViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,NSURLSessionDelegate>
{
    UIImageView *image;
    UILabel *lost;
    UILabel *found;
    UILabel *succeed;
    UILabel *reward;
    UILabel *name;
    UILabel *contact;
    UILabel *l;
    UILabel *f;
    UILabel *s;
    UILabel *r;
    UILabel *c;
    UIImageView *logo;
    UIButton *quit;
    User *currentUser;
}
@end

@implementation MeViewController

- (void)viewDidLoad {
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    currentUser = app.user;
    [app addObserver:self forKeyPath:@"user" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    [super viewDidLoad];
    self.title = @"ME";
    //set image
    CGFloat x = 0.3 * self.view.frame.size.width;
    CGFloat y = 0.2 * self.view.frame.size.height;
    CGFloat sidelength = 0.4 * self.view.frame.size.width;
    image = [[UIImageView alloc]initWithFrame:(CGRect)CGRectMake(x, y, sidelength, sidelength)];
    [self getImage];
    image.layer.cornerRadius = image.frame.size.width/2;
    image.layer.masksToBounds = YES;
    image.layer.borderWidth = 1.5f;
    image.layer.borderColor = UIColor.grayColor.CGColor;
    //enable image-change
    image.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(alterChangeImage:)];
    [image addGestureRecognizer:singleTap];
    [self.view addSubview:image];
    //set quit;
    x = 0.05 * self.view.frame.size.width;
    y = 0.8 * self.view.frame.size.height;
    CGFloat width = 0.9 * self.view.frame.size.width;
    CGFloat height = 0.06 * self.view.frame.size.height;
    quit = [[UIButton alloc]initWithFrame:(CGRect)CGRectMake(x, y, width, height)];
    [quit setTitle:@"Quit" forState:UIControlStateNormal];
    quit.backgroundColor = UIColor.redColor;
    [quit addTarget:self action:@selector(doQuit) forControlEvents:UIControlEventTouchUpInside];
    [quit.layer setCornerRadius:12];
    quit.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:quit];
    //set name
    name = [[UILabel alloc]init];
    [name setText:currentUser.name];
    [self.view addSubview:name];
    [name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.frame.size);
        make.height.mas_equalTo(50);
        make.top.equalTo(self->image.mas_bottom).offset(20);
    }];
    name.textAlignment = NSTextAlignmentCenter;
    name.font = [UIFont systemFontOfSize:50];
    //set Info
    [self setInfo];
    
}
- (void)getImage{
    if (currentUser == nil || currentUser.portraitURL == nil || [currentUser.portraitURL isEqualToString: @""])
        image.image = [UIImage imageNamed:@"loading.png"];
    else{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachePath = [paths objectAtIndex:0];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *filePath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_portrait",currentUser.name]];
        if ([fileManager fileExistsAtPath:filePath]){
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            image.image = [UIImage imageWithData:data];
        }else{
            image.image = [UIImage imageNamed:@"loading.png"];
            NSOperationQueue *queue = [[NSOperationQueue alloc]init];
            NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                                 delegate: self
                                                                            delegateQueue: queue];
            NSURL *url = [NSURL URLWithString:currentUser.portraitURL];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            NSURLSessionDataTask *dataTask = [delegateFreeSession dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                                    self->image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                                    [UIImagePNGRepresentation(self->image.image) writeToFile:filePath atomically:YES];
                });
            }];
            
            [dataTask resume];
        }
    }
}

- (void)alterChangeImage:(UITapGestureRecognizer *)gesture{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"Select from album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *PickerImage = [[UIImagePickerController alloc]init];
        PickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        PickerImage.allowsEditing = YES;
        PickerImage.delegate = self;
        [self presentViewController:PickerImage animated:YES completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    image.image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration:defaultConfigObject delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *url = [NSURL URLWithString:@"http://192.168.1.102:8001/api/setPortrait"];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setHTTPMethod:@"POST"];
    
    //TODO getImageURL
    currentUser.portraitURL = @"https://hbimg.huabanimg.com/d8784bbeac692c01b36c0d4ff0e072027bb3209b106138-hwjOwX_fw658";
    NSDictionary *dic = @{@"username": currentUser.name, @"portrait": @"https://hbimg.huabanimg.com/d8784bbeac692c01b36c0d4ff0e072027bb3209b106138-hwjOwX_fw658"};
    
    NSError * error = nil;
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString * jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    [urlRequest setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLSessionTask *dataTask = [defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error == nil) {
     //      NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if([dict[@"status"] isEqualToString:@"success"]){
                //TODO
                NSLog(@"Change Portrait success");
            }
            if([dict[@"status"] isEqualToString:@"fail"]){
                //TODO
                NSLog(@"Change Portrait fail");
            }
        }
    }];
    [dataTask resume];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doQuit{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    app.user = nil;
}

- (void)setInfo{
    int fontSize = 30;
    //set lost
    lost = [[UILabel alloc]init];
    lost.text = @"Lost";
    lost.font = [UIFont systemFontOfSize:fontSize];
    [self.view addSubview:lost];
    [lost mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.view.frame.size.width);
        make.height.mas_equalTo(self.view.frame.size.height * 0.1);
        make.top.equalTo(self->name.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(20);
    }];
    l = [[UILabel alloc]init];
    l.text = currentUser.lost;
    l.font = [UIFont systemFontOfSize:fontSize];
    l.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:l];
    [l mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.frame.size.width * 0.4);
        make.height.mas_equalTo(self.view.frame.size.height * 0.1);
        make.width.mas_equalTo(self.view.frame.size.width * 0.5);
        make.top.equalTo(self->lost.mas_top);
    }];
    //set found
    found = [[UILabel alloc]init];
    found.text = @"Found";
    found.font = [UIFont systemFontOfSize:fontSize];
    [self.view addSubview:found];
    [found mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self->lost);
        make.height.mas_equalTo(self->lost);
        make.top.equalTo(self->lost).offset(fontSize);
        make.left.equalTo(self->lost);
    }];
    f = [[UILabel alloc]init];
    f.text = currentUser.found;
    f.font = [UIFont systemFontOfSize:fontSize];
    f.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:f];
    [f mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.frame.size.width * 0.4);
        make.height.mas_equalTo(self.view.frame.size.height * 0.1);
        make.width.mas_equalTo(self.view.frame.size.width * 0.5);
        make.top.equalTo(self->found.mas_top);
    }];
    //set succeed
    succeed = [[UILabel alloc]init];
    succeed.text = @"Succeed";
    succeed.font = [UIFont systemFontOfSize:fontSize];
    [self.view addSubview:succeed];
    [succeed mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self->lost);
        make.height.mas_equalTo(self->lost);
        make.top.equalTo(self->found).offset(fontSize);
        make.left.equalTo(self->lost);
    }];
    s = [[UILabel alloc]init];
    s.text = currentUser.succeed;
    s.font = [UIFont systemFontOfSize:fontSize];
    s.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:s];
    [s mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.frame.size.width * 0.4);
        make.height.mas_equalTo(self.view.frame.size.height * 0.1);
        make.width.mas_equalTo(self.view.frame.size.width * 0.5);
        make.top.equalTo(self->succeed.mas_top);
    }];
    //set reward
    reward = [[UILabel alloc]init];
    reward.text = @"Reward";
    reward.font = [UIFont systemFontOfSize:fontSize];
    [self.view addSubview:reward];
    [reward mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self->lost);
        make.height.mas_equalTo(self->lost);
        make.top.equalTo(self->succeed).offset(fontSize);
        make.left.equalTo(self->lost);
    }];
    r = [[UILabel alloc]init];
    r.text = currentUser.reward;
    r.font = [UIFont systemFontOfSize:fontSize];
    r.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:r];
    [r mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.frame.size.width * 0.4);
        make.height.mas_equalTo(self.view.frame.size.height * 0.1);
        make.width.mas_equalTo(self.view.frame.size.width * 0.5);
        make.top.equalTo(self->reward.mas_top);
    }];
    //set contact
    contact = [[UILabel alloc]init];
    contact.text = @"Contact";
    contact.font = [UIFont systemFontOfSize:fontSize];
    [self.view addSubview:contact];
    [contact mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self->lost);
        make.height.mas_equalTo(self->lost);
        make.top.equalTo(self->reward).offset(fontSize);
        make.left.equalTo(self->lost);
    }];
    c = [[UILabel alloc]init];
    c.text = currentUser.contact;
    c.font = [UIFont systemFontOfSize:fontSize];
    c.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:c];
    [c mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.frame.size.width * 0.4);
        make.height.mas_equalTo(self.view.frame.size.height * 0.1);
        make.width.mas_equalTo(self.view.frame.size.width * 0.5);
        make.top.equalTo(self->contact.mas_top);
    }];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    currentUser = app.user;
    if (currentUser == nil)
        return;
    NSLog(@"ME OBSERVE %@",currentUser.name);
    name.text = currentUser.name;
    l.text = currentUser.lost;
    f.text = currentUser.found;
    s.text = currentUser.succeed;
    r.text = currentUser.reward;
    c.text = currentUser.contact;
    [self getImage];
}
@end
