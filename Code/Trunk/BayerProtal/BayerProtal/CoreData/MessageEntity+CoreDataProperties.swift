//
//  MessageEntity+CoreDataProperties.swift
//  BayerProtal
//
//  Created by Matt Quan on 16/3/17.
//  Copyright © 2016年 DNE Technology Co.,Ltd. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension MessageEntity {

    @NSManaged var identifier: String?
    @NSManaged var content: String?
    @NSManaged var isRead: NSNumber?
    @NSManaged var date: String?

}
