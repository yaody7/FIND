//
//  User.h
//  FIND
//
//  Created by ydy on 2020/2/19.
//  Copyright © 2020 ydy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject
@property (nonatomic, copy)NSString *lost;
@property (nonatomic, copy)NSString *found;
@property (nonatomic, copy)NSString *succeed;
@property (nonatomic, copy)NSString *name;
@property (nonatomic, copy)NSString *contact;
@property (nonatomic, copy)NSString *reward;
@property (nonatomic, copy)NSString *portraitURL;


@end

NS_ASSUME_NONNULL_END
