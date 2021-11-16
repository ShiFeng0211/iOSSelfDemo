//
//  Student.m
//  Arithmetic
//
//  Created by v_shifeng on 2020/11/14.
//  Copyright © 2020 weibo. All rights reserved.
//

#import "Student.h"

@implementation Student

#define TEST @"tetet"

#define ENUM_VALUE(name,assign) name assign,

#pragma mark - Enum Factory Macros
// expansion macro for enum value definition
#define ENUM_VALUE(name,assign) name assign,

// expansion macro for enum to string conversion
#define ENUM_CASE(name,assign) case name: return @#name;

// expansion macro for string to enum conversion
#define ENUM_STRCMP(name,assign) if (![string isEqualToString:@#name]) return name;

/// declare the access function and define enum values
//DECLARE_ENUM(EnumType,ENUM_DEF)
//typedef enum EnumType {
//ENUM_DEF(ENUM_VALUE)
//}EnumType;
//
//NSString *NSStringFrom##EnumType(EnumType value);
//EnumType EnumType##FromNSString(NSString *string);


-(void)encodeWithCoder:(NSCoder *)coder {
    
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeBool:self.sex forKey:@"sex"];
}

-(id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.sex = [coder decodeBoolForKey:@"sex"];
        
    }
    
    
    
    
    return self;
}

@end
