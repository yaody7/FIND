//
//  InfoTableViewCell.m
//  FIND
//
//  Created by ydy on 2020/2/18.
//  Copyright © 2020 ydy. All rights reserved.
//

#import "InfoTableViewCell.h"

@interface InfoTableViewCell ()

@end
@implementation InfoTableViewCell
- (void)setName:(NSString *)name setContact:(NSString *)contact setTime:(NSString *)time{
    //set name
    self.name = [[UILabel alloc]initWithFrame:(CGRect)CGRectMake(80, 12, self.frame.size.width, 20)];
    self.name.text = [NSString stringWithFormat:@"Thing：    %@",name];
    [self addSubview:self.name];
    //set contact
    self.contact = [[UILabel alloc]initWithFrame:(CGRect)CGRectMake(80, 40, self.frame.size.width, 20)];
    self.contact.text = [NSString stringWithFormat:@"Contact：%@",contact];
    [self addSubview:self.contact];
    //set time
    self.time = [[UILabel alloc]initWithFrame:(CGRect)CGRectMake(self.frame.size.width, 15, 100, 20)];
    self.time.text = time;
    self.time.textColor = UIColor.grayColor;
    self.time.font = [UIFont systemFontOfSize:12 weight:5];
    [self addSubview:self.time];
    //set image
    self.image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading.png"]];
    self.image = [[UIImageView alloc]initWithFrame:(CGRect)CGRectMake(0, 0, 80, 80)];
    self.image.image = [UIImage imageNamed:@"loading.png"];
    [self addSubview:self.image];
}

@end
