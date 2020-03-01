//
//  UITextViewWithPlaceholder.m
//  FIND
//
//  Created by ydy on 2020/2/29.
//  Copyright © 2020 ydy. All rights reserved.
//

#import "UITextViewWithPlaceholder.h"
@interface UITextViewWithPlaceholder()<UITextViewDelegate>
{

}
@end
@implementation UITextViewWithPlaceholder

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholder = [[UILabel alloc]initWithFrame:(CGRect)CGRectMake(0, 0, frame.size.width, 40)];
        self.placeholder.font = [UIFont systemFontOfSize:25];
        self.placeholder.textColor = UIColor.grayColor;
        [self addSubview:self.placeholder];
        [self setDelegate:self];
    }
    return self;
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    self.placeholder.hidden = YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    if(self.text.length == 0){
        self.placeholder.hidden = NO;
    }else{
        self.placeholder.hidden = YES;
    }
}
- (void)dealloc
{
    [self setDelegate:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
