//
//  InfoViewController.h
//  FIND
//
//  Created by ydy on 2020/2/18.
//  Copyright © 2020 ydy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController

@property (nonatomic, copy) NSString* type;
@property (nonatomic, strong) UIView *search;
- (instancetype)initWithType:(NSString *)type;

@end

