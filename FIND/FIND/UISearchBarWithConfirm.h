//
//  UISearchBarWithConfirm.h
//  FIND
//
//  Created by ydy on 2020/3/3.
//  Copyright © 2020 ydy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISearchBarWithConfirm : UIView<UISearchBarDelegate>

@property (nonatomic, copy) NSString *searchText;
@property (nonatomic, strong) UISearchBar* searchBar;
@property (nonatomic, strong) UIButton *btn;

- (UIButton *)getBtn;
@end

NS_ASSUME_NONNULL_END
