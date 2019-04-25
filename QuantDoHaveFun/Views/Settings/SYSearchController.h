//
//  SYSearchController.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/19.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - search
@class SYSearchController;
@protocol SYSearchControllerDelegate <NSObject>
- (void)resultViewController:(SYSearchController *)resultVC didSelectFollowCity:(NSString*)cityName;
@end
@interface SYSearchController : UISearchController <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, copy) NSArray *results;
@property (nonatomic, weak) id<SYSearchControllerDelegate>resultDelegate;
@property (nonatomic, strong) UIView *maskView;


@end

NS_ASSUME_NONNULL_END
