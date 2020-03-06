//
//  DetailViewController.h
//  FIND
//
//  Created by ydy on 2020/3/2.
//  Copyright © 2020 ydy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailViewController : UIViewController
@property (strong, nonatomic) UIView *thing;
@property (strong, nonatomic) UIView *image;
@property (strong, nonatomic) UIView *detail;
@property (strong, nonatomic) UIView *contact;
@property (strong, nonatomic) NSDictionary *info;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
