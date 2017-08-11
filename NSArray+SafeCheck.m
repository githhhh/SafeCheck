//
//  NSArray+SafeCheck.m
//  QYER
//
//  Created by qyer on 15/3/11.
//  Copyright (c) 2015年 QYER. All rights reserved.
//

#import "NSArray+SafeCheck.h"
#import "NSObject+Swizzle.h"
#import <objc/message.h>
#import <objc/runtime.h>

typedef id (*MsgSend_Fun)(id, SEL, const id*,unsigned int);

static id array_safe_initWithObjects(id self, SEL _cmd, const id* objects,unsigned int count){
    id orignialResult = nil;
    @try {
        MsgSend_Fun msgFun = (MsgSend_Fun)objc_msgSend;
        
        orignialResult = msgFun(self, NSSelectorFromString(@"array_safe_initWithObjects:count:"),objects,count);
    }
    @catch (NSException *exception) {
#ifdef DEBUG
        NSLog(@"=__NSPlaceholderArray===BUSTED!");
        NSAssert(NO,@"%@",exception);
#endif
    }
    return orignialResult ;
}

@implementation NSArray (SafeCheck)

+(void)load{
    
    //
    [objc_getClass("__NSArrayI") swizzleInstanceSelector:@selector(objectAtIndex:) withNewSelector:@selector(arrayI_ObjectsAtIndex:)];
    
    [objc_getClass("__NSArray0") swizzleInstanceSelector:@selector(objectAtIndex:) withNewSelector:@selector(array0_ObjectsAtIndex:)];

    //@[nil,a,b] return nil 只限语法糖初始化
    [objc_getClass("__NSPlaceholderArray")   swizzleSelector: @selector(initWithObjects:count:)
                                             withNewSelector: NSSelectorFromString(@"array_safe_initWithObjects:count:")
                                                   andNewIMP: (IMP)&array_safe_initWithObjects];
}

-(id)array0_ObjectsAtIndex:(NSUInteger)index{
    if (index < self.count) {
        id obj = [self array0_ObjectsAtIndex:index];
        return  obj;
    }else{
#ifdef DEBUG
        NSAssert(NO, @"index %lu > count %lu", (unsigned long)index, (unsigned long)self.count);
#elif ADHOC
        NSAssert(NO, @"index %lu > count %lu", (unsigned long)index, (unsigned long)self.count);
#endif
        return nil;
    }
    
}


-(id)arrayI_ObjectsAtIndex:(NSUInteger)index{
    if (index < self.count) {
        id obj = [self arrayI_ObjectsAtIndex:index];
        return  obj;
    }else{
#ifdef DEBUG
        NSAssert(NO, @"index %lu > count %lu", (unsigned long)index, (unsigned long)self.count);
#elif ADHOC
        NSAssert(NO, @"index %lu > count %lu", (unsigned long)index, (unsigned long)self.count);
#endif
        return nil;
    }
}


@end
