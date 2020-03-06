//
//  InfoViewModel.h
//  FIND
//
//  Created by ydy on 2020/2/18.
//  Copyright © 2020 ydy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface InfoViewModel : NSObject <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) NSMutableArray *info;
@property (strong, nonatomic) NSMutableArray *backup;
@property (copy, nonatomic) NSString *type;
@property (strong, nonatomic) UITableView *table;
@property (strong, nonatomic) UISearchBar *search;
@property (strong, nonatomic) DetailViewController *vc;
@end

NS_ASSUME_NONNULL_END
