//
//  QDStrategyDTO.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/28.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QDStrategyDTO : NSObject

@property (nonatomic, assign) NSInteger id;                     //酒店代码
@property (nonatomic, strong) NSString *title;                  //标题
@property (nonatomic, strong) NSString *content;                //
@property (nonatomic, strong) NSString *keyword;                //关键字
@property (nonatomic, strong) NSString *litimg;                 //缩略图
@property (nonatomic, strong) NSString *createTime;             //发布时间
@property (nonatomic, strong) NSString *startCreateTime;        //关键字
@property (nonatomic, strong) NSString *endCreateTime;          //结束时间
@property (nonatomic, strong) NSString *updateTime;             //更新时间
@property (nonatomic, strong) NSString *orderTime;              //排序时间
@property (nonatomic, strong) NSString *creater;                //创建人
@property (nonatomic, strong) NSString *lookNum;                //浏览数
@property (nonatomic, strong) NSString *collectNum;             //收藏数
@property (nonatomic, strong) NSString *likeTime;               //点赞数
@property (nonatomic, assign) NSInteger applyState;             //审核状态 0-待审核 1审核通过 2审核不通过
@property (nonatomic, assign) NSInteger postState;              //上架状态 0未上架 1 上架
@property (nonatomic, assign) NSInteger isCollect;              //是否收藏
@property (nonatomic, strong) NSString *postColumn;             //发布栏目
@property (nonatomic, strong) NSString *userId;                 //
@property (nonatomic, strong) NSArray *postColumnList;          //发布栏目集合
@property (nonatomic, strong) NSArray *imageList;

@end

NS_ASSUME_NONNULL_END
