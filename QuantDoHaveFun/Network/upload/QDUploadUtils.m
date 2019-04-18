//
//  QDUploadUtils.m
//  Pods
//
//  Created by 🐟猛 on 2018/8/14.
//
//

#import "QDUploadUtils.h"
#import <CommonCrypto/CommonDigest.h>

NSString * const kUploadedImages = @"com.quantdo.app.uploadedImages";
NSString * const kUploadedImageKey =  @"com.quantdo.app.uploadedImageKey";
NSString * const kUploadedImageUrl =  @"com.quantdo.app.uploadedImageUrl";


@implementation QDUploadUtils

/////////////////////////////////////////////////////////////

// 每次初始化检查，防止上传过程中强退或者crash导致失败的image未清除
+ (void)removeUnfinishedImagesInfo
{
    NSMutableArray *muteArray = [NSMutableArray array];
    NSArray *array = [[NSUserDefaults standardUserDefaults] objectForKey:kUploadedImages];
    if (array) {
        muteArray = [NSMutableArray arrayWithArray:array];
    }
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:muteArray];
    
    [tempArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSString *url = obj[kUploadedImageUrl];
            if (![url hasPrefix:@"http"]) {
                [muteArray removeObject:obj];
            }
        }
    }];
    
    if (muteArray) {
        [[NSUserDefaults standardUserDefaults] setObject:muteArray forKey:kUploadedImages];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


// 判断是否已经上传过或者正在上传
+ (NSString *)checkWhetherUploadedOrInProgress:(NSString *)key
{
    __block NSString *url = nil;
    NSArray *uploadedArray = [[NSUserDefaults standardUserDefaults] objectForKey:kUploadedImages];
    [uploadedArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[NSDictionary class]]) {
            NSString *md5 = obj[kUploadedImageKey];
            if ([md5 isEqualToString:key]) {
                url = obj[kUploadedImageUrl];
                *stop = YES;
            }
        }
    }];
    
    return url;
}

/////////////////////////////////////////////////////////////

// 压缩图片
+ (NSData *)compressImage:(UIImage *)originalImage scale:(CGFloat)scale
{
    return UIImageJPEGRepresentation(originalImage, scale);
}

// 智能压缩图片
+ (NSData *)intelligentCompress:(UIImage *)image
{
    // 最大为2MB
    CGFloat compressSizeMB = 2.0f;
    CGFloat originMBSize = [self sizeFromImage:image];
    
    NSData *imageData;
    if (originMBSize > compressSizeMB) {
        imageData = UIImageJPEGRepresentation(image, 0.1f);
    } else if(originMBSize > 1.0f) {
        imageData = UIImageJPEGRepresentation(image, 0.3f);
    } else if(originMBSize > 0.5f) {
        imageData = UIImageJPEGRepresentation(image, 0.5f);
    } else {
        imageData = UIImageJPEGRepresentation(image, 0.7f);
    }
    
    while (imageData.length > 1024 * 1024 * compressSizeMB) {
        // 最大压缩比
        imageData = UIImageJPEGRepresentation(image, 0.0);
    }
    
    return imageData;
}

// 图片尺寸
+ (CGFloat)sizeFromImage:(UIImage *)image {
    int perMBBytes = 1024 * 1024;
    
    CGImageRef cgimage = image.CGImage;
    size_t bpp = CGImageGetBitsPerPixel(cgimage);
    size_t bpc = CGImageGetBitsPerComponent(cgimage);
    size_t bytes_per_pixel = bpp / bpc;
    
    long lPixelsPerMB  = perMBBytes/bytes_per_pixel;
    long totalPixel = CGImageGetWidth(image.CGImage)*CGImageGetHeight(image.CGImage);
    double totalFileMB = 1.0f * totalPixel/lPixelsPerMB;
    
    return totalFileMB;
}

// NSData to NSString
+ (NSString *)dataToMD5:(NSData *)data
{
    unsigned char result[16];
    CC_MD5(data.bytes, (CC_LONG)data.length, result);  // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSData *)md5ToData:(NSString *)md5
{
    return [md5 dataUsingEncoding:NSUTF8StringEncoding];
}

@end
