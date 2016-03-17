//
//  BPManager.swift
//  BayerProtal
//
//  Created by Matt Quan on 16/3/17.
//  Copyright © 2016年 DNE Technology Co.,Ltd. All rights reserved.
//

import UIKit

class BPManager: NSObject {

    class func requestURL(method: String) -> String {
        let serverURL = "http://BSGSGPS0297.AP.BAYER.CNB:8080/BayAssistant/"
        
        return serverURL + method
    }
    
    class func stringDate(date: NSDate) -> String {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return format.stringFromDate(date)
    }
    
}
