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
    
    override init() {
        super.init()
        
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
    
    func insertNewMessage(userInfo: NSDictionary) {
        NSLog("************开始插入一条消息记录")
        let context = CoreDataManager.defalutManager().childContext()
        context.performBlock { () -> Void in
            let message = MessageEntity.entity(userInfo["send_message_id"] as? String, context: context)
            message.identifier = userInfo["send_message_id"] as? String
            let aps = userInfo["aps"] as! NSDictionary
            let alert = aps["alert"] as! String
            let array = alert.componentsSeparatedByString("/")
            message.content = array.count > 1 ? array.last : array.first
            
            do {
                try context.save()
                CoreDataManager.defalutManager().saveContext({
                    // FIXME: Alert Test
                    dispatch_async(dispatch_get_main_queue(), {
                        let alertView = UIAlertView(title: "插入数据", message: message.content, delegate: nil, cancelButtonTitle: "确定")
                        alertView.show()
                    })
                    
                    NSLog("************结束插入一条消息记录")
                })
            }
            catch {}
        }
    }
    
    func readAllMessage() {
        let context = CoreDataManager.defalutManager().childContext()
        context.performBlock { () -> Void in
            let messages = self.getMessages(context)
            for message in messages {
                message.isRead = NSNumber(bool: true)
            }
            
            do {
                try context.save()
                CoreDataManager.defalutManager().saveContext({ () -> Void in
                    self.unReadCount = 0
                })
            }
            catch {}
        }
    }
    
    func readMessage(context: NSManagedObjectContext, messageId: String, completion:(() -> Void)?) {
        NSLog("************开始标记一条消息记录已读状态")
        let fetchReq = NSFetchRequest(entityName: "MessageEntity")
        fetchReq.predicate = NSPredicate(format: "identifier == %@", messageId)
        
        do {
            let fetchObjects = try context.executeFetchRequest(fetchReq)
            
            if fetchObjects.count > 0 {
                let message = fetchObjects.first as! MessageEntity
                let manager = AFHTTPRequestOperationManager()
                let date = BPManager.stringDate(NSDate())
                
                context.performBlock({ () -> Void in
                    message.isRead = NSNumber(bool: true)
                    
                    do {
                        try context.save()
                        CoreDataManager.defalutManager().saveContext({ () -> Void in
                            NSLog("************结束标记一条消息记录已读状态")
                            completion?()
                        })
                    }
                    catch {}
                })
                
                NSLog("************开始调用接口标记一条消息记录已读状态")
                manager.POST(BPManager.requestURL("mobile/mMessagesRead.action"), parameters: ["deviceID": "", "send_message_id": message.identifier!, "send_message_content": message.content!, "open_message_time": date], success: { (operation, response) -> Void in
                    NSLog("************结束调用接口标记一条消息记录已读状态")
                    completion?()
                    }, failure: { (operation, error) -> Void in
                        completion?()
                })
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
        
        let manager = AFHTTPRequestOperationManager()
        let date = lastSyncDate ?? BPManager.stringDate(NSDate())
        NSLog("************开始同步消息记录， 方法：\(BPManager.requestURL("mobile/mMessagesGet.action"))   时间: \(date)")
        manager.GET(BPManager.requestURL("mobile/mMessagesGet.action"), parameters: ["updatetime": date], success: { (operation, response) -> Void in
            // FIXME: Alert Test
            let responseString: String? = ""
            dispatch_async(dispatch_get_main_queue(), { 
                let alertView = UIAlertView(title: "接口成功", message: responseString, delegate: nil, cancelButtonTitle: "确定")
                alertView.show()
            })
            
            if response == nil {
                NSLog("************结束同步消息记录， response ＝ nil")
                completion?()
                
                return
            }
            
            guard let messages = response["SendMessageLog"] as? Array<Dictionary<String, AnyObject>> else {
                NSLog("************结束同步消息记录， response[SendMessageLog] ＝ nil")
                completion?()
                return
            }
            
            NSLog("************结束同步消息记录 返回数据：\(response)")
            
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
                NSLog("************结束同步消息记录 返回错误数据：\(error.userInfo)")
                dispatch_async(dispatch_get_main_queue(), {
                    let alertView = UIAlertView(title: "接口失败", message: "\(error.code)", delegate: nil, cancelButtonTitle: "确定")
                    alertView.show()
                })
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
                message.date = "2000"
            }
            
            do {
                try context.save()
                CoreDataManager.defalutManager().saveContext(nil)
            }
            catch {}
        }
    }
    
}
