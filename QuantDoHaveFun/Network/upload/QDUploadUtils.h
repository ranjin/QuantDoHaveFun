//
//  QDUploadUtils.h
//  Pods
//
//  Created by 🐟猛 on 2018/8/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern NSString * const kUploadedImages;
extern NSString * const kUploadedImageKey;
extern NSString * const kUploadedImageUrl;


@interface QDUploadUtils : NSObject

+ (void)removeUnfinishedImagesInfo;
+ (NSString *)checkWhetherUploadedOrInProgress:(NSString *)key;

+ (NSData *)compressImage:(UIImage *)originalImage scale:(CGFloat)scale;
+ (NSData *)intelligentCompress:(UIImage *)image;
+ (CGFloat)sizeFromImage:(UIImage *)image;
+ (NSString *)dataToMD5:(NSData *)data;
+ (NSData *)md5ToData:(NSString *)md5;
@end
