//
//  HistoyDto.swift
//  SiteAssessment
//
//  Created by chaomeng on 2018/9/20.
//  Copyright © 2018年 OMGdadada. All rights reserved.
//

import UIKit
enum UpdateStatusType {
    case Completed
    case Uploading
    case Waiting
    case Incomplete
    case uploadFailed
}

class HistoyDto: NSObject {
    var status: UpdateStatusType = .Completed
    var projectID : String? = ""
    
    
}
