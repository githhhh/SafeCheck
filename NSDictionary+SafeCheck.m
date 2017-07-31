//
//  NSDictionary+SafeCheck.m
//  My
//
//  Created by bin on 15/3/11.
//  Copyright (c) 2015年 My. All rights reserved.
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



/*
 * 返回类型校验
 */
- (NSArray*)arraySafeForKey:(NSString*)key
{
    id object = nil;
    if([self respondsToSelector:@selector(objectForKey:)] && key){
        object = [self objectForKey:key];
    }
    if(![object isKindOfClass:[NSArray class]]){
        object = nil;
    }
    return object;
}
- (NSDictionary*)dictionarySafeForKey:(NSString*)key
{
    id object = nil;
    if([self respondsToSelector:@selector(objectForKey:)] && key){
        object = [self objectForKey:key];
    }
    if(![object isKindOfClass:[NSDictionary class]]){
        object = nil;
    }
    return object;
}
- (NSString*)stringSafeForKey:(NSString*)key
{
    id object = nil;
    if([self respondsToSelector:@selector(objectForKey:)] && key){
        object = [self objectForKey:key];
    }
    
    
    if([object isKindOfClass:[NSNumber class]]){
        
        NSNumber*number = (NSNumber*)object;
        object = [number stringValue];
    }
    
    if(![object isKindOfClass:[NSString class]] && ![object isKindOfClass:[NSNumber class]]){
        object = nil;
    }
    return object;
}
- (NSMutableArray*)mutableArraySafeForKey:(NSString*)key
{
    id object = nil;
    if([self respondsToSelector:@selector(objectForKey:)] && key){
        object = [self objectForKey:key];
    }
    if(![object isKindOfClass:[NSMutableArray class]]){
        object = nil;
    }
    return object;
}
- (NSMutableDictionary*)mutableDictionarySafeForKey:(NSString*)key
{
    id object = nil;
    if([self respondsToSelector:@selector(objectForKey:)] && key){
        object = [self objectForKey:key];
    }
    if(![object isKindOfClass:[NSMutableDictionary class]]){
        object = nil;
    }
    return object;
}
- (NSInteger)integerSafeForKey:(NSString*)key
{
    id object = nil;
    NSInteger num = 0;
    if([self respondsToSelector:@selector(objectForKey:)] && key){
        object = [self objectForKey:key];
    }
    if([object respondsToSelector:@selector(integerValue)]){
        num = [object integerValue];
    }
    return num;
}
- (CGFloat)floatSafeForKey:(NSString*)key
{
    id object = nil;
    CGFloat num = 0;
    if([self respondsToSelector:@selector(objectForKey:)] && key){
        object = [self objectForKey:key];
    }
    if([object respondsToSelector:@selector(floatValue)]){
        num = [object floatValue];
    }
    return num;
}
- (int)intSafeForKey:(NSString*)key
{
    id object = nil;
    int num = 0;
    if([self respondsToSelector:@selector(objectForKey:)] && key){
        object = [self objectForKey:key];
    }
    if([object respondsToSelector:@selector(intValue)]){
        num = [object intValue];
    }
    return num;
}

@end
