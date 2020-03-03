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
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //set name
        self.name = [[UILabel alloc]initWithFrame:(CGRect)CGRectMake(80, 12, self.frame.size.width, 20)];
        [self addSubview:self.name];
        //set contact
        self.contact = [[UILabel alloc]initWithFrame:(CGRect)CGRectMake(80, 40, self.frame.size.width, 20)];
        [self addSubview:self.contact];
        //set time
        self.time = [[UILabel alloc]initWithFrame:(CGRect)CGRectMake(self.frame.size.width, 15, 100, 20)];
        self.time.textColor = UIColor.grayColor;
        self.time.font = [UIFont systemFontOfSize:12 weight:5];
        [self addSubview:self.time];
        //set image
        self.image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading.png"]];
        self.image = [[UIImageView alloc]initWithFrame:(CGRect)CGRectMake(10, 10, 60, 60)];
        self.image.image = [UIImage imageNamed:@"loading.png"];
        self.image.layer.cornerRadius = 10;
        self.image.clipsToBounds = YES;
        [self addSubview:self.image];
    }
    return self;
}
- (void)setName:(NSString *)name setContact:(NSString *)contact setTime:(NSString *)time{
    //set name
    self.name.text = [NSString stringWithFormat:@"Thing：    %@",name];
    //set contact
    self.contact.text = [NSString stringWithFormat:@"Contact：%@",contact];
    //set time
    self.time.text = time;
}

@end
