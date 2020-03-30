//
//  Yuan_Dictionary.m
//  FTP图影音
//
//  Created by 袁全 on 2020/3/25.
//  Copyright © 2020 袁全. All rights reserved.
//

#import "Yuan_Dictionary.h"

#pragma mark - 不可变

@implementation Yuan_Dictionary


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}


- (id)valueForUndefinedKey:(NSString *)key {
    
    return nil;
}


@end




#pragma mark - 可变

@implementation Yuan_MutableDictionary


- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    
}


- (id)valueForUndefinedKey:(NSString *)key {
    
    return nil;
}


@end
