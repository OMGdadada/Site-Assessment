//
//  HistoyDto.swift
//  SiteAssessment
//
//  Created by chaomeng on 2018/9/20.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit
enum UpdateStatusType {
    case Completed    // 已完成
    case Uploading    // 上传中
    case Pending      // 未上传
    case Incomplete   // 未完成
    case uploadFailed // 上传失败
}

class HistoyDto: NSObject {
    var status: UpdateStatusType = .Completed
    var projectID : String? = ""
    var uploaded:Bool = false
    var Datauploaded = false
    
    
    
    
}
