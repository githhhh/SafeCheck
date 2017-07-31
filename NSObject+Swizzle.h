//
//  NSObject+Swizzle.h
//  My
//
//  Created by bin on 16/2/2.
//  Copyright © 2016年 My-inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzle)

+ (void) swizzleInstanceSelector:(SEL)originalSelector
                 withNewSelector:(SEL)newSelector;

+ (void) swizzleClassSelector:(SEL)originalSelector
              withNewSelector:(SEL)newSelector;

+ (void) swizzleSelector:(SEL)originalSelector
         withNewSelector:(SEL)newSelector
               andNewIMP:(IMP)imp;
@end
