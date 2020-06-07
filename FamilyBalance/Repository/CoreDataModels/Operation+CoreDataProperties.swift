//
//  Operation+CoreDataProperties.swift
//  FamilyBalance
//
//  Created by Anastasia Reyngardt on 04.06.2020.
//  Copyright © 2020 GermanyHome. All rights reserved.
//
//

import Foundation
import CoreData


extension Operation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Operation> {
        return NSFetchRequest<Operation>(entityName: "Operation")
    }

    @NSManaged public var sum: Double
    @NSManaged public var date: Date?
    @NSManaged public var category: Category?
    @NSManaged public var account: Account?

}
