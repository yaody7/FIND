//
//  QCloud.h
//  FIND
//
//  Created by ydy on 2020/2/26.
//  Copyright © 2020 ydy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QCloudCore.h>
#import <QCloudCOSXML/QCloudCOSXMLService.h>
#import <QCloudCOSXML/QCloudCOSXMLEndPoint.h>
#import <QCloudCOSXML/QCloudCOSTransferMangerService.h>
#import <QCloudCOSXML/QCloudCOSXMLUploadObjectRequest.h>
#import <QCloudCOSXML/QCloudCOSXMLDownloadObjectRequest.h>
#import <QCloudCOSXML/QCloudGetObjectRequest.h>


NS_ASSUME_NONNULL_BEGIN

@interface QCloud : NSObject<QCloudSignatureProvider>
- (void)uploadImage:(UIImage *)image named:(NSString *)name;
- (NSString *)getURL:(NSString *)image;
@end

NS_ASSUME_NONNULL_END
