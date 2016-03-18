//
//  MessageManager.swift
//  BayerProtal
//
//  Created by Matt Quan on 16/3/17.
//  Copyright © 2016年 DNE Technology Co.,Ltd. All rights reserved.
//

import UIKit
import CoreData

class MessageManager: NSObject {
    
    var unReadCount = 0
    var lastSyncDate: String? {
        get {
            return NSUserDefaults.standardUserDefaults().stringForKey("BPMessageLastSyncDate")
        }
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "BPMessageLastSyncDate")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

    static let _messageManager = MessageManager()
    
    class func defaultManager() -> MessageManager {
        return _messageManager
    }
    
    func getMessages(context: NSManagedObjectContext) -> Array<MessageEntity> {
        let fetchReq = NSFetchRequest(entityName: "MessageEntity")
        
        do {
            let fetchObjects = try context.executeFetchRequest(fetchReq)
            
            return fetchObjects as! Array<MessageEntity>
        }
        catch {
            return [MessageEntity]()
        }
    }
    
    func synthronizeMessages(completion: (() -> Void)?) {
        let manager = AFHTTPRequestOperationManager()
        let date = lastSyncDate ?? ""
        manager.GET(BPManager.requestURL("Bayer_portal/mobile/muser!MessageList.action"), parameters: ["updatetime": date], success: { (operation, response) -> Void in
            guard let messages = response["SendMessageLog"] as? Array<Dictionary<String, AnyObject>> else {
                completion?()
                return
            }
            
            self.lastSyncDate = BPManager.stringDate(NSDate())
            
            let context = CoreDataManager.defalutManager().childContext()
            context.performBlock({ () -> Void in
                for info in messages {
                    let message = MessageEntity.entity(info["send_message_id"] as? String, context: context)
                    message.identifier = info["send_message_id"] as? String
                    message.content = info["send_message_content"] as? String
                    message.date = info["send_message_time"] as? String
                }
                
                do {
                    try context.save()
                    CoreDataManager.defalutManager().saveContext({ () -> Void in
                        let fetchReq = NSFetchRequest(entityName: "MessageEntity")
                        fetchReq.predicate = NSPredicate(format: "isRead == %@", NSNumber(bool: false))
                        
                        do {
                            let fetchObjects = try context.executeFetchRequest(fetchReq)
                            self.unReadCount = fetchObjects.count
                        }
                        catch {
                        
                        }
                        
                        completion?()
                    })
                }
                catch {
                    completion?()
                }
            })
            
            }) { (operation, error) -> Void in
                
        }
    }
    
}
