//
//  LD_NSStringEditor.m
//  TuLvTravel
//
//  Created by Li on 15-3-5.
//  Copyright (c) 2015年 AleX. All rights reserved.
//

#import "LD_NSStringEditor.h"
#import <CommonCrypto/CommonDigest.h>
@implementation LD_NSStringEditor
+(CGSize)sizeOfStringWithString:(NSString *)aString limitSize:(CGSize)limitSize fontSize:(CGFloat)fontSize{
    if (aString==nil||aString.length==0) {
        return CGSizeZero;
    }
//    //  获取字符串的range
//    NSRange range=NSMakeRange(0, aString.length);
//    //  创建  NSMutableAttributeString
//    NSMutableAttributedString *attributeString=[[NSMutableAttributedString alloc]initWithString:aString];
//    //  为attributeString添加相关属性
//    [attributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:fontSize] range:range];
    //  计算字符串rect
    //  可选枚举的使用
    CGRect stringRect = [aString boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil];
//    CGRect stringRect=[attributeString boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:NULL];
    stringRect.size.height = ceil(CGRectGetHeight(stringRect));
    return stringRect.size;
}
+(NSString *)cookieString{
    static const size_t dataLength = 72;
    NSMutableData *data = [NSMutableData dataWithLength:dataLength];
    SecRandomCopyBytes(kSecRandomDefault, dataLength, data.mutableBytes);
    return [NSString stringWithString:[data base64EncodedStringWithOptions:0]];
}
+(NSString *)changePhoneNumberWithPlus:(NSString *)phoneNumber{
    if (![phoneNumber containsString:@"+"]) {
        phoneNumber = [NSString stringWithFormat:@"+86%@",phoneNumber];
    }
    return phoneNumber;
}


+(NSString *)md5:(NSString *)inputText
{
    if (inputText==nil || [inputText length]==0) {
        return nil;
    }
    
    const char *value = [inputText UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger count=0; count<CC_MD5_DIGEST_LENGTH; count++) {
        [outputString appendFormat:@"%02x", outputBuffer[count]];
    }
    
    return [outputString lowercaseString];
}
+ (NSString *)parseUnicode:(NSString *)unicodeStr {
    return [unicodeStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^{}\"[]|\\<> "].invertedSet];
}
//判断内容是否全部为空格  yes 全部为空格  no 不是
+ (BOOL)isEmpty:(NSString *)str{
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}
+(int)convertToInt:(NSString*)strtemp{
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}
+(NSString *)convertDateToString:(NSDate *)date{
    
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *yesterday;
    NSDate *anteayer;
    
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    anteayer = [today dateByAddingTimeInterval:-secondsPerDay*2];
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * yesterdayString = [[yesterday description] substringToIndex:10];
    NSString *anteayerString = [[anteayer description]substringToIndex:10];
    NSString *thisYearString = [[today description]substringToIndex:4];
    
    NSString * dateString = [[date description] substringToIndex:10];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if ([dateString isEqualToString:todayString]){
        [dateFormatter setDateFormat:@"今天 HH:mm"];
    } else if ([dateString isEqualToString:yesterdayString]){
        [dateFormatter setDateFormat:@"昨天 HH:mm"];
    }else if([dateString isEqualToString:anteayerString]){
        [dateFormatter setDateFormat:@"前天 HH:mm"];
    }else if([[dateString substringToIndex:4] isEqualToString:thisYearString]){   // 今年的不显示年份
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
    }else{
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    }
    return [dateFormatter stringFromDate:date];
}



@end

@implementation NSString (LDPredicate)
-(BOOL)isNumberLetterHanzi{
    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5\\d]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}
-(BOOL)isOnlyChinese
{
    NSString * chineseTest=@"^[\u4e00-\u9fa5]{0,}$";
    NSPredicate*chinesePredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",chineseTest];
    return [chinesePredicate evaluateWithObject:self];
}

-(BOOL)isOnlyNumber
{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < self.length) {
        NSString * string = [self substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

+(NSString *)randomString32MixNumber{
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < 32; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 65;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}
-(NSDictionary *)parseJSONStringToNSDictionary{
    NSData *JSONData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"%@",error);
    }
    return responseJSON;
}
-(NSString *)removeUnescapedControlCharacter{
    NSCharacterSet *controlChars = [NSCharacterSet controlCharacterSet];//获取那些特殊字符
    NSRange range = [self rangeOfCharacterFromSet:controlChars];//寻找字符串中有没有这些特殊字符
    if (range.location != NSNotFound)
    {
        NSMutableString *mutable = [NSMutableString stringWithString:self];
        while (range.location != NSNotFound)
        {
            [mutable deleteCharactersInRange:range];//去掉这些特殊字符
            range = [mutable rangeOfCharacterFromSet:controlChars];
        }
        return mutable;
    }
    return self;
}
//单个文件的大小
-(long long)fileSizeAtPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:self]){
        return [[manager attributesOfItemAtPath:self error:nil] fileSize];
//        return folderSize/(1024.0*1024.0);
    }
    return 0;
}
-(NSString *)mimeTypeAtPath{
    NSURL *url = [NSURL fileURLWithPath:self];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 只有响应头中才有其真实属性 也就是MIME
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    return response.MIMEType;
}

//URLEncode

-(NSString*)encodeString{
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    return encodedString;
}
//URLDEcode
-(NSString *)decodeString
{
    //NSString *decodedString = [encodedString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding ];
    NSString *decodedString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                    (__bridge CFStringRef)self,
                                                                                                                    CFSTR(""),
                                                                                                                    CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}
+(NSString *)plusStrings:(id)firstArg, ...NS_REQUIRES_NIL_TERMINATION{
    NSString *tmp;
    if ([firstArg isKindOfClass:[NSString class]]) {
        tmp = [NSString stringWithFormat:@"%@",firstArg];
    }else{
        tmp = [NSString stringWithFormat:@"%ld",(long)firstArg];
    }
    // 定义一个指向个数可变的参数列表指针；
    va_list args;
    // 初始化变量刚定义的va_list变量，这个宏的第二个参数是第一个可变参数的前一个参数，是一个固定的参数
    va_start(args, firstArg);
    // 用于存放取出的参数
    id arg;
    // 遍历全部参数 va_arg返回可变的参数(a_arg的第二个参数是你要返回的参数的类型)
    while ((arg = va_arg(args, id))) {
        if ([arg isKindOfClass:[NSString class]]) {
            tmp = [tmp stringByAppendingString:arg];
        }else{
            NSString *string = [NSString stringWithFormat:@"%@",arg];
            tmp = [tmp stringByAppendingString:string];
        }
    }
    // 清空参数列表，并置参数指针args无效
    va_end(args);
    return tmp;
}
@end
