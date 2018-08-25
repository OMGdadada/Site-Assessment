//
//  siteRootModel.h
//  SiteAssessment
//
//  Created by Jacob on 2018/8/25.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MJExtension/MJExtension.h>
@class QuestionModel;
@interface SiteRootModel : NSObject
@property (nonatomic ,copy) NSString *heading;
@property (nonatomic ,strong) NSArray <QuestionModel *> *questionList;
@property (nonatomic ,assign) BOOL isSelect; // 是否选中  0 不是  1 是


@end

@interface QuestionModel :NSObject
@property (nonatomic ,copy) NSString *Question;
@property (nonatomic ,copy) NSString *DefaultValue;
@property (nonatomic ,copy) NSString *IsNoShow;
@property (nonatomic ,copy) NSString *Item;
@property (nonatomic ,copy) NSArray *option;
@end