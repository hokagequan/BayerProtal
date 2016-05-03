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
    
    var unReadCount: Int {
        let context = CoreDataManager.defalutManager().managedObjectContext
        let fetchReq = NSFetchRequest(entityName: "MessageEntity")
        fetchReq.predicate = NSPredicate(format: "isRead == %@", NSNumber(bool: false))
        
        do {
            let fetchObjects = try context.executeFetchRequest(fetchReq)
            
            return fetchObjects.count
        }
        catch {
            return 0
        }
    }
    
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
    
    override init() {
        super.init()
        
        // FIXME: Test
//        self.insertMessages()
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
    
    func insertNewMessage(userInfo: NSDictionary, read: Bool) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { 
            let context = CoreDataManager.defalutManager().managedObjectContext
            context.performBlock { () -> Void in
                let messageID = "\(userInfo["id"]!)"
                let message = MessageEntity.entity(messageID, context: context)
                message.identifier = messageID
                let aps = userInfo["aps"] as! NSDictionary
                let alert = aps["alert"] as! String
//                let array = alert.componentsSeparatedByString("/")
                message.content = alert
                message.isRead = NSNumber(bool: read)
                message.date = BPManager.stringDate(NSDate())
                
                CoreDataManager.defalutManager().saveContext({
                    if read == true {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.readMessage(context, messageId: messageID, completion: nil)
                        })
                    }
                })
            }
//        }
    }

    func readAllMessage() {
        let context = CoreDataManager.defalutManager().managedObjectContext
        context.performBlock { () -> Void in
            let messages = self.getMessages(context)
            for message in messages {
                message.isRead = NSNumber(bool: true)
            }
            
            CoreDataManager.defalutManager().saveContext({ () -> Void in
                dispatch_async(dispatch_get_main_queue(), {
                    NSNotificationCenter.defaultCenter().postNotificationName("changeNotifyMark", object: nil)
                })
            })
        }
    }
    
    func readMessage(context: NSManagedObjectContext, messageId: String, completion:(() -> Void)?) {
        let storedMessage = MessageEntity.entity(messageId, context: CoreDataManager.defalutManager().managedObjectContext)
        let date = BPManager.stringDate(NSDate())
        
        if storedMessage.identifier != nil {
            RequestClient.POST(BPManager.requestURL("mobile/mMessagerRead.action"), parameters: ["deviceID": BPManager.defaultManager().deviceID, "send_message_id": storedMessage.identifier!, "send_message_content": storedMessage.content!, "open_message_time": date], success: { (response) in
                completion?()
                }, failure: { (error) in
                    completion?()
            })
        }
        
        let fetchReq = NSFetchRequest(entityName: "MessageEntity")
        fetchReq.predicate = NSPredicate(format: "identifier == %@", messageId)
        
        do {
            let fetchObjects = try context.executeFetchRequest(fetchReq)
            
            if fetchObjects.count > 0 {
                let message = fetchObjects.first as! MessageEntity
                
                context.performBlock({ () -> Void in
                    message.isRead = NSNumber(bool: true)
                    CoreDataManager.defalutManager().saveContext({ () -> Void in
                        completion?()
                        dispatch_async(dispatch_get_main_queue(), {
                            NSNotificationCenter.defaultCenter().postNotificationName("changeNotifyMark", object: nil)
                        })
                    })
                })
                
//                let urlString = "\(BPManager.requestURL("mobile/mMessagesRead.action?"))deviceID=\(BPManager.defaultManager().deviceID)&send_message_id=\(message.identifier!)&send_message_content=\(message.content!)&open_message_time=\(date)"
//                let encode = urlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
//                manager.GET(encode, parameters: nil, success: { (operation, response) in
//                    completion?()
//                    }, failure: { (operation, error) in
//                        completion?()
//                })
//
            }
            else {
                completion?()
            }
        }
        catch {
            completion?()
        }
    }
    
    func synthronizeMessages(completion: (() -> Void)?) {
        let date = lastSyncDate ?? BPManager.stringDate(NSDate())
        
        RequestClient.POST(BPManager.requestURL("mobile/mMessagerlistNew.action"), parameters: ["updatetime": date], success: { (response) in
            
            if response == nil {
                completion?()
                
                return
            }
            
            guard let messageList = response["body"] as? Dictionary<String, AnyObject> else {
                completion?()
                return
            }
            
            guard let messages = messageList["messageList"] as? Array<Dictionary<String, AnyObject>> else {
                completion?()
                
                return
            }
            
            NSLog("************结束同步消息记录 返回数据：\(response)")
            
            self.lastSyncDate = BPManager.stringDate(NSDate())
            
            let context = CoreDataManager.defalutManager().managedObjectContext
            context.performBlock({ () -> Void in
                for info in messages {
                    let messageID = "\(info["send_message_id"]!)"
                    let message = MessageEntity.entity(messageID, context: context)
                    message.identifier = messageID
                    message.content = info["send_message_content"] as? String
                    message.date = info["send_message_time"] as? String
                }
                
                CoreDataManager.defalutManager().saveContext({ () -> Void in
                    dispatch_async(dispatch_get_main_queue(), {
                        NSNotificationCenter.defaultCenter().postNotificationName("changeNotifyMark", object: nil)
                    })
                    
                    completion?()
                })
            })
            }) { (error) in
        }
    }
    
    func setTheLastSyncDate() {
        if lastSyncDate == nil {
            lastSyncDate = BPManager.stringDate(NSDate())
        }
    }
    
    /// @brief 测试数据
    func insertMessages() {
        let context = CoreDataManager.defalutManager().childContext()
        context.performBlock { () -> Void in
            for i in 0...10 {
                let message = MessageEntity.entity("\(i)", context: context)
                message.identifier = "\(i)"
                message.content = "content\(i)"
                message.date = BPManager.stringDate(NSDate())
            }
            
            do {
                try context.save()
                CoreDataManager.defalutManager().saveContext(nil)
            }
            catch {}
        }
    }
    
}
