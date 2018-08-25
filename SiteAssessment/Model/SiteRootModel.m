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

@end
