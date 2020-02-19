//
//  InfoViewModel.m
//  FIND
//
//  Created by ydy on 2020/2/18.
//  Copyright © 2020 ydy. All rights reserved.
//

#import "InfoViewModel.h"
#import "InfoTableViewCell.h"
@implementation InfoViewModel
{
    NSArray *info;
}
//TODO
- (void) getInfo {
    //Test
    info = [[NSArray alloc]initWithObjects:@1,@2,@3, nil];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil){
        cell = [[InfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell setName:@"Mobile phone" setContact:@"13512345678" setTime:@"2020/01/01"];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    [self getInfo];
    return [info count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}



@end
