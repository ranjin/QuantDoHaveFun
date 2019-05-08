//
//  NSObject+LDCopying.h
//  carDV
//
//  Created by lidi on 2019/1/25.
//  Copyright © 2019 rc. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NSObject (LDCopying)

/**
 * 多层深拷贝。model必须支持KVC。
* 需要特殊处理的类可重写该方法。
 @return 拷贝生成的新对象
 */
- (id)LDDeepCopy;



@end


