//
//  MessageEntity.swift
//  BayerProtal
//
//  Created by Matt Quan on 16/3/17.
//  Copyright © 2016年 DNE Technology Co.,Ltd. All rights reserved.
//

import Foundation
import CoreData


class MessageEntity: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    class func entity(identifier: String?, context: NSManagedObjectContext) -> MessageEntity {
        if identifier == nil {
            return NSEntityDescription.insertNewObjectForEntityForName("MessageEntity", inManagedObjectContext: context)
        }
    }

}
