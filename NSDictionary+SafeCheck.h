//
//  NSDictionary+SafeCheck.h
//  My
//
//  Created by bin on 15/3/11.
//  Copyright (c) 2015年 My. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SafeCheck)


/*
 * 返回类型校验
 */
- (NSArray*)arraySafeForKey:(NSString*)key;
- (NSDictionary*)dictionarySafeForKey:(NSString*)key;
- (NSString*)stringSafeForKey:(NSString*)key;
- (NSMutableArray*)mutableArraySafeForKey:(NSString*)key;
- (NSMutableDictionary*)mutableDictionarySafeForKey:(NSString*)key;
- (NSInteger)integerSafeForKey:(NSString*)key;
- (CGFloat)floatSafeForKey:(NSString*)key;
- (int)intSafeForKey:(NSString*)key;

@end
