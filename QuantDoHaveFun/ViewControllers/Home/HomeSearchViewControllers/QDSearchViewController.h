//
//  QDSearchViewController.h
//  TravelPoints
//
//  Created by 冉金 on 2019/2/23.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import "QDOrderField.h"
NS_ASSUME_NONNULL_BEGIN

typedef void (^SearchHotelListResult)(NSMutableArray *hotelList, NSMutableArray *imgList);

@protocol GetSearchStrDelegate <NSObject>

- (void)getSearchStr:(NSString *)searchKeyWords;

@end
@interface QDSearchViewController : UIViewController
@property (nonatomic, copy) SearchHotelListResult searchHotelListResult;
@property (nonatomic, assign) id <GetSearchStrDelegate> delegate;
@property (nonatomic, assign) QDPlayShellType playShellType;

@property (nonatomic, strong) NSArray *rankList;
@property (nonatomic, strong) NSString *pushOrPresent;
@property (nonatomic, strong) NSString *dateInStr;
@property (nonatomic, strong) NSString *dateOutStr;

- (void)getHotelList:(SearchHotelListResult)block;

@end

NS_ASSUME_NONNULL_END
