//
//  QDMsgVerifyView.h
//  TravelPoints
//
//  Created by 冉金 on 2019/1/15.
//  Copyright © 2019年 Charles Ran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBverifyButton.h" 
NS_ASSUME_NONNULL_BEGIN

@interface QDMsgVerifyView : UIView
@property (nonatomic, strong) UILabel *identifyLab;
@property (nonatomic, retain) GBverifyButton *sendBtn;

@property (nonatomic, strong) NSString *legalPhone;

@end

NS_ASSUME_NONNULL_END
