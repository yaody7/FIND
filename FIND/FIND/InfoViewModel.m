//
//  InfoViewModel.m
//  FIND
//
//  Created by ydy on 2020/2/18.
//  Copyright © 2020 ydy. All rights reserved.
//

#import "InfoViewModel.h"
#import "InfoTableViewCell.h"
#import "AppDelegate.h"
#import "DetailViewController.h"

@interface InfoViewModel()<NSURLSessionDelegate>
{
    NSOperationQueue *imageQueue;
}
@end
@implementation InfoViewModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        imageQueue = [[NSOperationQueue alloc]init];
    }
    return self;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil){
        cell = [[InfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NSDictionary *dict = [self.info objectAtIndex:indexPath.row];
    [cell setName:dict[@"Thing"] setContact:dict[@"contact"] setTime:dict[@"Time"]];
    if (dict[@"Portrait"] == nil || [dict[@"Portrait"] isEqualToString: @""])
        cell.image.image = [UIImage imageNamed:@"loading.png"];
    else{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *cachePath = [paths objectAtIndex:0];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *filePath = [cachePath stringByAppendingPathComponent:dict[@"Portrait"]];
        if ([fileManager fileExistsAtPath:filePath]){
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            cell.image.image = [UIImage imageWithData:data];
        }else{
            cell.image.image = [UIImage imageNamed:@"loading.png"];
            NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *delegateFreeSession = [NSURLSession sessionWithConfiguration: defaultConfigObject
                                                                                 delegate: self
                                                                            delegateQueue: imageQueue];
            AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            NSString *imageURL = [NSString stringWithFormat:@"%@%@",app.QCloudIP,dict[@"Portrait"]];
            NSURL *url = [NSURL URLWithString:imageURL];
            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            NSURLSessionDataTask *dataTask = [delegateFreeSession dataTaskWithRequest:request completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    NSLog(@"%@",[UIImage imageWithData:[NSData dataWithContentsOfURL:url]]);
                    cell.image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
                    [UIImagePNGRepresentation(cell.image.image) writeToFile:filePath atomically:YES];
                });
            }];
            [dataTask resume];
        }
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.info count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.vc = [[DetailViewController alloc]initWithDict:[self.info objectAtIndex:indexPath.row]];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self->imageQueue cancelAllOperations];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self.table reloadData];
}
@end
