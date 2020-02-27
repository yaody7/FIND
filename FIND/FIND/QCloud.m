//
//  QCloud.m
//  FIND
//
//  Created by ydy on 2020/2/26.
//  Copyright © 2020 ydy. All rights reserved.
//

#import "QCloud.h"

@implementation QCloud
- (instancetype)init
{
    self = [super init];
    if (self) {
        QCloudServiceConfiguration *configuration = [QCloudServiceConfiguration new];
        configuration.appID = @"1301391093";
        configuration.signatureProvider = self;
        QCloudCOSXMLEndPoint *endpoint = [[QCloudCOSXMLEndPoint alloc]init];
        endpoint.regionName = @"ap-guangzhou";
        configuration.endpoint = endpoint;
        [QCloudCOSXMLService registerDefaultCOSXMLWithConfiguration:configuration];
        [QCloudCOSTransferMangerService registerDefaultCOSTransferMangerWithConfiguration:configuration];
    }
    return self;
}

- (void)uploadImage:(UIImage *)image named:(NSString *)name{
    QCloudCOSXMLUploadObjectRequest *put = [QCloudCOSXMLUploadObjectRequest new];
    put.object = name;
    put.bucket = @"find-1301391093";
    put.body = UIImagePNGRepresentation(image);
    [[QCloudCOSTransferMangerService defaultCOSTransferManager] UploadObject:put];
}
- (NSString *)getURL:(NSString *)image{
    return [[QCloudCOSXMLService defaultCOSXML] getURLWithBucket:@"find-1301391093" object:image withAuthorization:NO regionName:@"ap-guangzhou"];
}

- (void) signatureWithFields:(QCloudSignatureFields*)fileds
                     request:(QCloudBizHTTPRequest*)request
                  urlRequest:(NSMutableURLRequest*)urlRequst
                   compelete:(QCloudHTTPAuthentationContinueBlock)continueBlock
{

    QCloudCredential* credential = [QCloudCredential new];
    credential.secretID = @"AKIDxgw540GleCdsxrPAZnlvsiMm2BBg5IOI";
    credential.secretKey = @"qqdFpPlvskLiu1nPua6P6j9apvGiw2LQ";
    QCloudAuthentationV5Creator* creator = [[QCloudAuthentationV5Creator alloc] initWithCredential:credential];
    QCloudSignature* signature =  [creator signatureForData:urlRequst];
    continueBlock(signature, nil);
}

@end
