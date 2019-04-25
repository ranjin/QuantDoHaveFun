//
//  ImageDTO.h
//  TravelPoints
//
//  Created by WJ-Shao on 2019/2/26.
//  Copyright © 2019 Charles Ran. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ImageDTO : NSObject
@property (nonatomic, assign) NSUInteger id;

@property (nonatomic, strong) NSString *mapId;
@property (nonatomic, strong) NSString *imageSource;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *imageDesc;
@property (nonatomic, strong) NSString *imageType;
@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *imageFilename;
@property (nonatomic, strong) NSString *imageFullUrl;
@property (nonatomic, strong) NSString *url;

@end

NS_ASSUME_NONNULL_END
