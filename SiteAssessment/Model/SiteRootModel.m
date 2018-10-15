//
//  siteRootModel.m
//  SiteAssessment
//
//  Created by Jacob on 2018/8/25.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

#import "SiteRootModel.h"
#import <MJExtension/MJExtension.h>

@implementation SiteRootModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"questionList":@"QuestionList"};
}

 + (NSDictionary *)mj_objectClassInArray
{
    return @{@"questionList":[QuestionModel class]};
}

@end

@implementation QuestionModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"defaultValue":@"DefaultValue"};
}

- (NSString *)other
{
    if (_other == nil) {
        return @"";
    }
    return _other;
}
- (NSString *)left
{
    if (_left == nil) {
        return @"";
    }
    return _left;
}

- (NSString *)top
{
    if (_top == nil) {
        return @"";
    }
    return _top;
}

- (NSString *)bottom
{
    if (_bottom == nil) {
        return @"";
    }
    return _bottom;
}

- (NSString *)right
{
    if (_right == nil) {
        return @"";
    }
    return _right;
}

- (NSString *)textStr
{
    if (_textStr == nil) {
        return @"";
    }
    return _textStr;
}

@end
