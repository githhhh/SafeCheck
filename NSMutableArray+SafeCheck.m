//
//  NSMutableArray+SafeCheck.m
//  QYER
//
//  Created by qyer on 15/3/11.
//  Copyright (c) 2015年 QYER. All rights reserved.
//

#import "NSMutableArray+SafeCheck.h"
#import <objc/runtime.h>
#import "NSObject+Swizzle.h"

@implementation NSMutableArray (SafeCheck)

+(void)load{
    //取值
    [objc_getClass("__NSArrayM") swizzleInstanceSelector:@selector(objectAtIndex:) withNewSelector:@selector(safeObjectsAtIndex:)];
    [objc_getClass("__NSArrayM") swizzleInstanceSelector:@selector(objectAtIndexedSubscript:) withNewSelector:@selector(subscript_ObjectsAtIndex:)];

    // 添加
    [objc_getClass("__NSArrayM") swizzleInstanceSelector:@selector(addObject:) withNewSelector:@selector(safeAddObject:)];
    // 插入
    [objc_getClass("__NSArrayM") swizzleInstanceSelector:@selector(insertObject:atIndex:) withNewSelector:@selector(safeInsertObject:atIndex:)];
    //移除
    [objc_getClass("__NSArrayM") swizzleInstanceSelector:@selector(removeObjectAtIndex:) withNewSelector:@selector(safeRemoveObjectAtIndex:)];
    //替换
    [objc_getClass("__NSArrayM") swizzleInstanceSelector:@selector(replaceObjectAtIndex:withObject:) withNewSelector:@selector(safeReplaceObjectAtIndex:withObject:)];
    
    
}

-(void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)object{
    if (object == nil) {
#ifdef DEBUG
        NSAssert(NO, @"replaceObjectAtIndex:withObject:****object is nil");
#elif ADHOC
        NSAssert(NO, @"replaceObjectAtIndex:withObject:****object is nil");
#endif
        return;
    }
    if (index < self.count) {
        [object retain];
        [self safeReplaceObjectAtIndex:index withObject:object];
        [object release];
    }else {
#ifdef DEBUG
        NSAssert(NO, @"index %lu > count %lu on replaceObjectAtIndex:withObject:", (unsigned long)index, (unsigned long)self.count);
#elif ADHOC
        NSAssert(NO, @"index %lu > count %lu on replaceObjectAtIndex:withObject:", (unsigned long)index, (unsigned long)self.count);
#endif
    }
}


-(void)safeRemoveObjectAtIndex:(NSUInteger)index{
    if (index < self.count) {
        [self safeRemoveObjectAtIndex:index];
    }else {
#ifdef DEBUG
        NSAssert(NO, @"index %lu > count %lu on removeObjectAtIndex:", (unsigned long)index, (unsigned long)self.count);
#elif ADHOC
        NSAssert(NO, @"index %lu > count %lu on removeObjectAtIndex:", (unsigned long)index, (unsigned long)self.count);
#endif
    }
}



-(void)safeInsertObject:(id)object atIndex:(NSUInteger)index{
    if (object == nil) {
#ifdef DEBUG
        NSAssert(NO, @"insertObject:atIndex:****object is nil");
#elif ADHOC
        NSAssert(NO, @"insertObject:atIndex:****object is nil");
#endif
        return;
    }
    if ((index <= self.count) ) {//|| (index == 0 && self.count == 0)
        [object retain];
        [self safeInsertObject:object atIndex:index];
        [object release];
    }else {
#ifdef DEBUG
        NSAssert(NO, @"index %lu > count %lu on insertObject:atIndex:", (unsigned long)index, (unsigned long)self.count);
#elif ADHOC
        NSAssert(NO, @"index %lu > count %lu on insertObject:atIndex:", (unsigned long)index, (unsigned long)self.count);
#endif
    }
}


-(void)safeAddObject:(id)object{
    if (object) {
        [object retain];
        [self safeAddObject:object];
        [object release];
    }else{
#ifdef DEBUG
        NSAssert(NO, @"index %lu > count %lu on addObject:", (unsigned long)index, (unsigned long)self.count);
#elif ADHOC
        NSAssert(NO, @"index %lu > count %lu on addObject:", (unsigned long)index, (unsigned long)self.count);
#endif
    }
}




-(id)subscript_ObjectsAtIndex:(NSUInteger)index{
    @autoreleasepool {
        if (index < self.count) {
            return [self subscript_ObjectsAtIndex:index];
        }else{
#ifdef DEBUG
            NSAssert(NO, @"index %lu > count %lu on objectAtIndex:", (unsigned long)index, (unsigned long)self.count);
#elif ADHOC
            NSAssert(NO, @"index %lu > count %lu on objectAtIndex:", (unsigned long)index, (unsigned long)self.count);
#endif
            return nil;
        }
    }
}


-(id)safeObjectsAtIndex:(NSUInteger)index{
    @autoreleasepool {
        if (index < self.count) {
            return [self safeObjectsAtIndex:index];
        }else{
#ifdef DEBUG
            NSAssert(NO, @"index %lu > count %lu on objectAtIndex:", (unsigned long)index, (unsigned long)self.count);
#elif ADHOC
            NSAssert(NO, @"index %lu > count %lu on objectAtIndex:", (unsigned long)index, (unsigned long)self.count);
#endif
            return nil;
        }
    }
}


@end
