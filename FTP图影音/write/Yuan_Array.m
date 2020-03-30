//
//  Yuan_Array.m
//  FTP图影音
//
//  Created by 袁全 on 2020/3/25.
//  Copyright © 2020 袁全. All rights reserved.
//

#import "Yuan_Array.h"

#pragma mark - 不可变

@implementation Yuan_Array

- (id)objectAtIndex:(NSUInteger)index {
    
    if (index >= [self count]) {

        return nil;

    }

    id value = [self objectAtIndex:index];

    if (value == [NSNull null]){

        return nil;

    }

    return value;

}


- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    
    if (idx >= [self count]) {

        return nil;

    }

    id value = [self objectAtIndex:idx];

    if (value == [NSNull null]){

        return nil;

    }

    return value;
    
}

@end



#pragma mark - 可变

@implementation Yuan_MutableArray

- (id)objectAtIndex:(NSUInteger)index {
    
    if (index >= [self count]) {

        return nil;

    }

    id value = [self objectAtIndex:index];

    if (value == [NSNull null]){

        return nil;

    }

    return value;

}


@end
