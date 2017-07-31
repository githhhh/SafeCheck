//
//  NSArray+SafeCheck.h
//  My
//
//  Created by bin on 15/3/11.
//  Copyright (c) 2015年 My. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (SafeCheck)

/*
 * 返回类型校验
 */
- (NSArray*)arraySafeFromIndex:( NSUInteger)index;
- (NSDictionary*)dictionarySafeFromIndex:( NSUInteger)index;
- (NSString*)stringSafeFromIndex:( NSUInteger)index;
- (NSMutableArray*)mutableArraySafeFromIndex:( NSUInteger)index;
- (NSMutableDictionary*)mutableDictionarySafeFromIndex:( NSUInteger)index;
- (NSInteger)integerSafeFromIndex:( NSUInteger)index;
- (CGFloat)floatSafeFromIndex:( NSUInteger)index;
- (int)intSafeFromIndex:( NSUInteger)index;
@end
