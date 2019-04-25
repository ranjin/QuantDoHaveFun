//
//  QDKeyWordsSearchVC.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/2/27.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QDOrderField.h"
NS_ASSUME_NONNULL_BEGIN

@interface QDKeyWordsHomePageVC : UIViewController

@property (nonatomic, assign) QDPlayShellType playShellType;

@property (nonatomic, strong) NSString *dateInStr;
@property (nonatomic, strong) NSString *dateOutStr;

//yyyy-MM-dd格式的日期
@property (nonatomic, strong) NSString *dateInPassedVal;
@property (nonatomic, strong) NSString *dateOutPassedVal;

@property (nonatomic, strong) NSMutableArray *hotelListInfoArr;
@property (nonatomic, strong) NSMutableArray *hotelImgArr;

@property (nonatomic, strong) NSMutableArray *dzyListInfoArr;
@property (nonatomic, strong) NSMutableArray *dzyImgArr;

@property (nonatomic, strong) NSMutableArray *mallInfoArr;
@property (nonatomic, strong) NSString *keyWords;
@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *hotelTypeId;    //酒店类型
@property (nonatomic, strong) NSString *hotelLevel;     //酒店星级
@property (nonatomic, strong) NSString *minPrice;       //最小价格
@property (nonatomic, strong) NSString *maxPrice;       //最大价格

@end

NS_ASSUME_NONNULL_END
