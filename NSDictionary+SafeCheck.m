//
//  NSDictionary+SafeCheck.m
//  QYER
//
//  Created by qyer on 15/3/11.
//  Copyright (c) 2015年 QYER. All rights reserved.
//

#import "NSDictionary+SafeCheck.h"
#import "NSObject+Swizzle.h"

#import <objc/message.h>
#import <objc/runtime.h>

typedef id (*MsgSend_Fun)(id, SEL, const id*,const id*,unsigned int);

static id dic_safe_initWithObjects(id self, SEL _cmd, const id* objects, const id* keys, unsigned int count) {
    
    id orignialResult = nil;
    
    @try {
        MsgSend_Fun msgFun = (MsgSend_Fun)objc_msgSend;

        orignialResult = msgFun(self,  NSSelectorFromString(@"dic_safe_initWithObjects:forKeys:count:"), objects, keys, count);
    }
    @catch (NSException *exception) {
#ifdef DEBUG
        NSLog(@"__NSPlaceholderDictionary===BUSTED!");
        NSAssert(NO,@"%@",exception);
#endif
    }
    
    return orignialResult;
}

@implementation NSDictionary (SafeCheck)

+ (void)load{
    
      [objc_getClass("__NSPlaceholderDictionary") swizzleSelector:@selector(initWithObjects:forKeys:count:)
                                                  withNewSelector:NSSelectorFromString(@"dic_safe_initWithObjects:forKeys:count:")
                                                        andNewIMP:(IMP)&dic_safe_initWithObjects];
    
}



@end
