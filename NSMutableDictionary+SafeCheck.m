//
//  NSMutableDictionary+SafeCheck.m
//  QYER
//
//  Created by qyer on 15/3/11.
//  Copyright (c) 2015年 QYER. All rights reserved.
//

#import "NSMutableDictionary+SafeCheck.h"
#import "NSObject+Swizzle.h"
#import <objc/runtime.h>

@implementation NSMutableDictionary (SafeCheck)

+ (void)load{
    
    [objc_getClass("__NSDictionaryM") swizzleInstanceSelector:@selector(setObject:forKey:) withNewSelector:@selector(safeSetObject:forKey:)];
    
}

- (void)safeSetObject:(id)object forKey:(id <NSCopying>)key{
    if(!object || !key){
#ifdef DEBUG
        NSAssert(NO, @"setObject:forKey:****object or key is nil");
#elif ADHOC
        NSAssert(NO, @"setObject:forKey:****object or key is nil");
#endif
        return;
    }
    [self safeSetObject:object forKey:key];
}



@end
