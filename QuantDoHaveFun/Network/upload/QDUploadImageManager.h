//
//  QDUploadImageManager.h
//  WXIOS
//
//  Created by 🐟猛 on 2018/8/14.
//  Copyright © 2018年 quantdo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDUploadImageManager : NSObject

+ (instancetype)manager;


- (void)uploadImageWithUrlStr:(NSString *)urlStr AndImage:(UIImage *)image withSuccessBlock:(RequestSuccess)successBlock withFailurBlock:(RequestFailure)failureBlock withUpLoadProgress:(UploadProgress)progress;


/**
 * 超时时间
 */
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/**
 * 压缩比
 */
@property (nonatomic, assign) CGFloat scale;

/**
 * 智能压缩，默认为YES
 */
@property (nonatomic, assign) BOOL intelligentCompress;
@end
