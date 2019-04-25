//
//  QDResponseObject.h
//  QDINFI
//
//  Created by ZengTark on 2017/10/24.
//  Copyright © 2017年 quantdo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QDResponseObject : NSObject

@property (nonatomic, assign)NSInteger code;

@property (nonatomic, strong)NSString * message;

@property (nonatomic, strong)id result;

@property (nonatomic, assign)BOOL success;

@end
