//
//  UISearchBarWithConfirm.m
//  FIND
//
//  Created by ydy on 2020/3/3.
//  Copyright © 2020 ydy. All rights reserved.
//

#import "UISearchBarWithConfirm.h"
@implementation UISearchBarWithConfirm

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.searchBar];
        [self addSubview:self.btn];
    }
    return self;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.searchText = searchText;
}

- (UISearchBar *)searchBar{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    _searchBar = [[UISearchBar alloc]initWithFrame:(CGRect)CGRectMake(0, 0, 0.8 * width, height)];
    _searchBar.barTintColor = UIColor.whiteColor;
    _searchBar.placeholder = @"Please Enter Something";
    _searchBar.backgroundImage = [[UIImage alloc]init];
    UITextField *searchField = [_searchBar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor whiteColor]];
        searchField.layer.cornerRadius  = 13.0f;
        searchField.layer.borderColor   = [UIColor grayColor].CGColor;
        searchField.layer.borderWidth   = 1;
        searchField.layer.masksToBounds = YES;
    }
    return _searchBar;
}
- (UIButton *)btn{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    _btn = [[UIButton alloc]initWithFrame:(CGRect)CGRectMake(0.8 * width, 0.1 * height, 0.2 * width, 0.8 * height)];
    [_btn setTitle:@"Search" forState:UIControlStateNormal];
    _btn.backgroundColor = UIColor.greenColor;
    [_btn.layer setCornerRadius:12];
    _btn.titleLabel.font = [UIFont systemFontOfSize: 20.0];
    return _btn;
}

- (UIButton *)getBtn{
    return _btn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
