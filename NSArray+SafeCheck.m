//
//  NSArray+SafeCheck.m
//  My
//
//  Created by bin on 15/3/11.
//  Copyright (c) 2015年 My. All rights reserved.
//

#import "NSArray+SafeCheck.h"
#import "NSObject+Swizzle.h"
#import <objc/message.h>
#import <objc/runtime.h>
#define CurrentClass objc_getClass("__NSArrayI")
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
    //添加
    [CurrentClass swizzleInstanceSelector:@selector(objectAtIndex:) withNewSelector:@selector(safeObjectsAtIndex:)];
    
    [objc_getClass("__NSPlaceholderArray")   swizzleSelector: @selector(initWithObjects:count:)
                                             withNewSelector: NSSelectorFromString(@"array_safe_initWithObjects:count:")
                                                   andNewIMP: (IMP)&array_safe_initWithObjects];
}
-(id)safeObjectsAtIndex:(NSUInteger)index{
    if (index < self.count) {
        id obj = [self safeObjectsAtIndex:index];
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




/*
 * 返回类型校验
 */
- (NSArray*)arraySafeFromIndex:( NSUInteger)index
{
    
    id object = nil;
    if([self respondsToSelector:@selector(safeObjectsAtIndex:)]){
        object = [self safeObjectsAtIndex:index];
    }
    if(![object isKindOfClass:[NSArray class]]){
        object = nil;
    }
    return object;
}
- (NSDictionary*)dictionarySafeFromIndex:( NSUInteger)index
{
    id object = nil;
    if([self respondsToSelector:@selector(safeObjectsAtIndex:)] ){
        object = [self safeObjectsAtIndex:index];
    }
    if(![object isKindOfClass:[NSDictionary class]]){
        object = nil;
    }
    return object;
}
- (NSString*)stringSafeFromIndex:( NSUInteger)index
{
    id object = nil;
    if([self respondsToSelector:@selector(safeObjectsAtIndex:)]){
        object = [self safeObjectsAtIndex:index];
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
- (NSMutableArray*)mutableArraySafeFromIndex:( NSUInteger)index
{
    id object = nil;
    if([self respondsToSelector:@selector(safeObjectsAtIndex:)] ){
        object = [self safeObjectsAtIndex:index];
    }
    if(![object isKindOfClass:[NSMutableArray class]]){
        object = nil;
    }
    return object;
}
- (NSMutableDictionary*)mutableDictionarySafeFromIndex:( NSUInteger)index
{
    id object = nil;
    if([self respondsToSelector:@selector(safeObjectsAtIndex:)] ){
        object = [self safeObjectsAtIndex:index];
    }
    if(![object isKindOfClass:[NSMutableDictionary class]]){
        object = nil;
    }
    return object;
}
- (NSInteger)integerSafeFromIndex:( NSUInteger)index
{
    id object = nil;
    NSInteger num = 0;
    if([self respondsToSelector:@selector(safeObjectsAtIndex:)] ){
        object = [self safeObjectsAtIndex:index];
    }
    if([object respondsToSelector:@selector(integerValue)]){
        num = [object integerValue];
    }
    return num;
}
- (CGFloat)floatSafeFromIndex:( NSUInteger)index
{
    id object = nil;
    CGFloat num = 0;
    if([self respondsToSelector:@selector(safeObjectsAtIndex:)]){
        object = [self safeObjectsAtIndex:index];
    }
    if([object respondsToSelector:@selector(floatValue)]){
        num = [object floatValue];
    }
    return num;
}
- (int)intSafeFromIndex:( NSUInteger)index
{
    id object = nil;
    int num = 0;
    if([self respondsToSelector:@selector(safeObjectsAtIndex:)]){
        object = [self safeObjectsAtIndex:index];
    }
    if([object respondsToSelector:@selector(intValue)]){
        num = [object intValue];
    }
    return num;
}


@end
