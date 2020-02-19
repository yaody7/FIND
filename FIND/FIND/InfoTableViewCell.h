//
//  InfoTableViewCell.h
//  FIND
//
//  Created by ydy on 2020/2/18.
//  Copyright © 2020 ydy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *contact;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UIImageView *image;
- (void) setName:(NSString *)name setContact:(NSString*)contact setTime:(NSString*)time;
@end

NS_ASSUME_NONNULL_END
