//
//  User.h
//  FIND
//
//  Created by ydy on 2020/2/19.
//  Copyright © 2020 ydy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject
@property (nonatomic, strong)NSString *lost;
@property (nonatomic, strong)NSString *found;
@property (nonatomic, strong)NSString *succeed;
@property (nonatomic, strong)NSString *name;
@property (nonatomic, strong)NSString *contact;
@property (nonatomic, strong)NSString *reward;
@end

NS_ASSUME_NONNULL_END
