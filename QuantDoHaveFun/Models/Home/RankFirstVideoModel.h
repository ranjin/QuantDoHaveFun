//
//  RankFirstVideoModel.h
//  QuantDoHaveFun
//
//  Created by WJ-Shao on 2019/4/25.
//  Copyright © 2019 Chalres Ran. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RankFirstVideoModel : NSObject

@property (nonatomic, strong) NSString *cacheVideoId;
@property (nonatomic, strong) NSString *coverUrl;
@property (nonatomic, strong) NSString *sourceId;
@property (nonatomic, strong) NSString *sourceType;

@property (nonatomic, strong) NSString *videoTitle;

@end

NS_ASSUME_NONNULL_END
