//
//  Member+CoreDataProperties.swift
//  TestCoreDataSimple
//
//  Created by active on 2021/10/19.
//
//

import Foundation
import CoreData


extension Member {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Member> {
        return NSFetchRequest<Member>(entityName: "Member")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var pass: String?

}

extension Member : Identifiable {

}
