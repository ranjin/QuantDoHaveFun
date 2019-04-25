//
//  RanklistDTO.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/2/26.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDTO.h"
NS_ASSUME_NONNULL_BEGIN

@interface RanklistDTO : NSObject

@property (nonatomic, assign) NSUInteger id;
@property (nonatomic, strong) NSString *topicName;
@property (nonatomic, strong) NSString *topicDescribe;
@property (nonatomic, strong) NSString *listType;
@property (nonatomic, strong) NSString *listTypeContent;
@property (nonatomic, strong) NSString *labels;
@property (nonatomic, strong) NSString *labelsContent;
@property (nonatomic, strong) NSString *totalquantity;
@property (nonatomic, strong) NSString *invalidCommentCount;
@property (nonatomic, strong) NSString *validCommentCount;
@property (nonatomic, strong) NSString *listStatus;
@property (nonatomic, strong) NSString *listStatusContent;
@property (nonatomic, strong) NSString *rank;
@property (nonatomic, strong) ImageDTO *imageDTO;

@property (nonatomic, strong) NSString *isRecommend;
@property (nonatomic, strong) NSString *imageFullUrl;
@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *pageNum;
@property (nonatomic, strong) NSString *pageSize;
@property (nonatomic, strong) NSString *rankRule;
@property (nonatomic, strong) NSString *detailHomeImage;

@end

NS_ASSUME_NONNULL_END
