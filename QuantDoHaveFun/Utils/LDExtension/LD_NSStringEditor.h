//
//  LD_NSStringEditor.h
//  TuLvTravel
//
//  Created by Li on 15-3-5.
//  Copyright (c) 2015年 AleX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface LD_NSStringEditor : NSObject
/**
    计算某个字符串的rect，并返回rect的size
 @param aString 要计算的字符串
 @param limitSize 对该字符串的size限制条件
 @param fontSize 计算时使用的字体大小
 @return 返回字符串的实际大小
 */
+(CGSize)sizeOfStringWithString:(NSString *)aString limitSize:(CGSize)limitSize fontSize:(CGFloat)fontSize;
+(NSString *)cookieString;
/**
 把手机号转换成带+86的
 */
+(NSString *)changePhoneNumberWithPlus:(NSString *)phoneNumber;
/**
    md5加密
 */
+(NSString *)md5:(NSString *)inputText;
/**
解析unicode字符串
 */
+ (NSString *)parseUnicode:(NSString *)unicodeStr;
/**
 判断内容是否全部为空格
 @return yes 全部为空格  no 不是
 */
+ (BOOL)isEmpty:(NSString *)str;

/**
 计算文字长度。 汉字（汉字字符) : 1   英文数字（英文字符）: 0.5   emoji表情 : 2
 */
+(int)convertToInt:(NSString*)strtemp;

/**
 把NSDate日期转换成字符串，可显示昨天前天等，yyyy-MM-dd HH:mm
 */
+(NSString *)convertDateToString:(NSDate *)date;

@end

@interface NSString (LDPredicate)
/**
 * 字母、数字、中文正则判断（不包括空格）
 */
-(BOOL)isNumberLetterHanzi;
/**
 是否只有中文
 */
-(BOOL)isOnlyChinese;
/**
 是否只有数字
 */
-(BOOL)isOnlyNumber;

/**
  生成32位随机字母数字组合的字符串
 */
+(NSString* )randomString32MixNumber;
/**
    解析JSON字符串为NSDictionary字典对象
 */
-(NSDictionary *)parseJSONStringToNSDictionary;
/**
    移除字符串中的制表符，原字符串未改变
 */
-(NSString *)removeUnescapedControlCharacter;
/**
    获取该文件路径下的文件大小，未格式化显示
 */
-(long long)fileSizeAtPath;
/**
    获取该文件路径下文件的mimeType
 */
-(NSString *)mimeTypeAtPath;
/**
 URLDEcode
 */
-(NSString *)decodeString;
/**
 URLEncode
 */
-(NSString *)encodeString;

/**
 字符串拼接。
 只能传入对象类型 NSString和NSNumber类型，浮点型建议以字符串方式传入以控制位数
 使用示例 [NSString plusStrings:@"tom",@6,@"--",[NSNumber numberWithFloat:0.55900],@"7.99",@(1.0/3), nil];
 结果是tom6--0.5597.990.3333333333333333
 @param aArg 待拼接的元素，接收NSString和NSNumber类型
 @return 拼接完成的字符串
 */
+(NSString *)plusStrings:(id)firstArg, ...NS_REQUIRES_NIL_TERMINATION;

@end

