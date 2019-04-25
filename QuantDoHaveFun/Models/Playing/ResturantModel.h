//
//  ResturantModel.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/4/9.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface ResturantModel : NSObject

@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *restaurantName; //餐厅名
@property (nonatomic, strong) NSString *perCapita;      //人均价格
@property (nonatomic, strong) NSString *address;        //地址
@property (nonatomic, strong) NSMutableArray *restaurantImageList;    //图片集合

-(void)fillRestaurant:(ResturantModel *)infoModel andImgURL:(NSString *)imgURL;
@end

NS_ASSUME_NONNULL_END
