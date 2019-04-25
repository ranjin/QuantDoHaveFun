//
//  QDSalesInfo.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/2/26.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface QDSalesInfo : NSObject

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSArray *attachmentDTOList;
@property (nonatomic, strong) NSArray *bankaccountList;
@property (nonatomic, strong) NSString *contactEmail;
@property (nonatomic, strong) NSString *contactMobile;
@property (nonatomic, strong) NSString *contactName;
@property (nonatomic, strong) NSString *contactPhone;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *creater;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *faxNum;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString *legalCertNum;
@property (nonatomic, strong) NSString *legalCertType;
@property (nonatomic, strong) NSString *legalEmail;
@property (nonatomic, strong) NSString *legalName;
@property (nonatomic, strong) NSString *legalPhone;
@property (nonatomic, strong) NSString *province;
@property (nonatomic, strong) NSString *registeredCapital;
@property (nonatomic, strong) NSString *saleCode;
@property (nonatomic, strong) NSString *saleName;
@property (nonatomic, strong) NSString *saleState;
@property (nonatomic, strong) NSString *saleTypeIDesc;
@property (nonatomic, strong) NSString *saleTypeId;
@property (nonatomic, strong) NSString *socialNum;
@property (nonatomic, strong) NSString *userLoginId;
@property (nonatomic, strong) NSString *validityDate;

@end

NS_ASSUME_NONNULL_END
