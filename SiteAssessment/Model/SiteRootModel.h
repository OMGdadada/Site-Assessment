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
@property (nonatomic ,copy) NSString  *Question;  // 问题
@property (nonatomic ,copy) NSString  *defaultValue; // 选中的item标题
@property (nonatomic ,assign) BOOL    isReply; // 是否回答  0 不是  1 是
@property (nonatomic ,assign) BOOL    isShow;  //  是否回答  0 不是  1 是
@property (nonatomic ,assign) float   height; // cell 高度
@property (nonatomic ,assign) BOOL    IsNoShow; // 
@property (nonatomic ,copy) NSString  *Item;  // id
@property (nonatomic ,copy) NSArray   *option; // 选择集合
@property (nonatomic ,copy) NSString  *top;   //
@property (nonatomic ,copy) NSString  *left;
@property (nonatomic ,copy) NSString  *right;
@property (nonatomic ,copy) NSString  *bottom;
@property (nonatomic ,strong) NSArray *images;   // 图片集合
@property (nonatomic ,copy) NSString  *other;    // 选中的答案
@property (nonatomic ,assign) BOOL    ishidden; // 是否隐藏问题
@property (nonatomic ,copy) NSString  *textStr; 
@end
