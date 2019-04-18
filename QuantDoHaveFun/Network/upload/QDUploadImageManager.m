//
//  QDUploadImageManager.m
//  WXIOS
//
//  Created by 🐟猛 on 2018/8/14.
//  Copyright © 2018年 quantdo. All rights reserved.
//

#import "QDUploadImageManager.h"
#import "QDUploadUtils.h"
#import "AFNetworking.h"
#import "QDServiceErrorHandler.h"
#import "QDServiceClient.h"

@interface QDUploadImageManager ()

@property (nonatomic, strong) NSURLSessionConfiguration *sessionConfig;
@property (nonatomic, assign) BOOL isCancelled;

@end

@implementation QDUploadImageManager

#pragma mark - LifeCycle
+ (instancetype)manager {
    static dispatch_once_t once;
    static QDUploadImageManager *manager = nil;
    dispatch_once(&once, ^{
        manager = [[QDUploadImageManager alloc] init];
    });
    return manager;
}


- (id)init {
    self = [super init];
    if (self) {
        // 默认压缩比
        self.scale = 1.0;
        // 默认智能压缩，不然图片大于2M会上传失败
        self.intelligentCompress = YES;
        // 超时时间，默认为60秒
        self.timeoutInterval = [[NSURLRequest alloc] init].timeoutInterval;
    }
    
    return self;
}


#pragma mark - Utilities
- (NSData *)intelligentCompress:(UIImage *)originalImage{
    NSData *imageData = nil;
    if (self.intelligentCompress) {
        imageData = [QDUploadUtils intelligentCompress:originalImage];
    } else {
        imageData = [QDUploadUtils compressImage:originalImage scale:self.scale];
    }
    return imageData;
}


- (void)uploadImageWithUrlStr:(NSString *)urlStr AndImage:(UIImage *)image withSuccessBlock:(RequestSuccess)successBlock withFailurBlock:(RequestFailure)failureBlock withUpLoadProgress:(UploadProgress)progress{
    //image to data
    NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
    //    NSData *scaledData = [self intelligentCompress:image];
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.requestSerializer.timeoutInterval = QD_Timeout;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/xml",@"text/plain",@"application/xml", nil];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy = securityPolicy;
    NSString *cookie = [NSString stringWithFormat:@"%@", [QDUserDefaults getCookies]];
    [manager.requestSerializer setHTTPShouldHandleCookies:YES];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //set fileName with current time
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSDate *today = [NSDate date];
        NSString *fileName = [formatter stringFromDate:today];
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpeg"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        progress ? progress(uploadProgress) : nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSInteger errorCode = 200;
        @try {
            NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
            NSDictionary *allHeaders = response.allHeaderFields;
            NSNumber *code = [allHeaders objectForKey:@"error_code"];
            if (code != nil) {
                errorCode = [code integerValue];
            }
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
        if (errorCode == 200) {
            QDResponseObject *responseObj = [QDResponseObject yy_modelWithDictionary:responseObject];
            if (responseObj.code == 0) {
                successBlock ? successBlock(responseObj) : nil;
            }
            else {
                QDToast(@"上传图片失败，请重试或重新登录");
            }
        }
        else {
            [QDServiceErrorHandler handleError:errorCode];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


@end
