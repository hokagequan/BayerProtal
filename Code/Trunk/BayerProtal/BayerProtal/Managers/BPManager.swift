//
//  BPManager.swift
//  BayerProtal
//
//  Created by Matt Quan on 16/3/17.
//  Copyright © 2016年 DNE Technology Co.,Ltd. All rights reserved.
//

import UIKit

class BPManager: NSObject {
    
    var deviceID: String = ""
    
    static let _sharedBPManager = BPManager()
    
    class func defaultManager() -> BPManager {
        return _sharedBPManager
    }

    class func requestURL(method: String) -> String {
        let serverURL = ByServerURL.convertServerURL()
        
        return serverURL + method
    }
    
    class func stringDate(date: NSDate) -> String {
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return format.stringFromDate(date)
    }
    
    class func redirectNSlogToDocumentFolder() {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let path = paths.first
        let logPath = path?.stringByAppendingString("/bp.log")
        
        do {
            try NSFileManager.defaultManager().removeItemAtPath(logPath!)
        }
        catch {}
        
        freopen(logPath!, "a+", stdout)
        freopen(logPath!, "a+", stderr)
    }
    
}
