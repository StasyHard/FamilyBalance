//
//  Account+CoreDataProperties.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 04.06.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//
//

import Foundation
import CoreData


extension Account {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Account> {
        return NSFetchRequest<Account>(entityName: "Account")
    }

    @NSManaged public var title: String?
    @NSManaged public var operations: NSSet?

}

// MARK: Generated accessors for operations
extension Account {

    @objc(addOperationsObject:)
    @NSManaged public func addToOperations(_ value: Operation)

    @objc(removeOperationsObject:)
    @NSManaged public func removeFromOperations(_ value: Operation)

    @objc(addOperations:)
    @NSManaged public func addToOperations(_ values: NSSet)

    @objc(removeOperations:)
    @NSManaged public func removeFromOperations(_ values: NSSet)

}
