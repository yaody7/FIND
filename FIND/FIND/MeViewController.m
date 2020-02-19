//
//  MeViewController.m
//  FIND
//
//  Created by ydy on 2020/2/19.
//  Copyright © 2020 ydy. All rights reserved.
//

#import "MeViewController.h"

@interface MeViewController ()
{
    UIImageView *image;
    UILabel *lost;
    UILabel *found;
    UILabel *succeed;
    UILabel *reward;
    UILabel *name;
    UILabel *contact;
    UIImageView *logo;
}
@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ME";
    //set image
    CGFloat x = 0.3 * self.view.frame.size.width;
    CGFloat y = 0.2 * self.view.frame.size.height;
    CGFloat sidelength = 0.4 * self.view.frame.size.width;
    image = [[UIImageView alloc]initWithFrame:(CGRect)CGRectMake(x, y, sidelength, sidelength)];
    image.image = [UIImage imageNamed:@"loading.png"];
    [self.view addSubview:image];
    //set lost;
    
}



@end
