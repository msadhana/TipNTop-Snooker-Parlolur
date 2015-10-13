//
//  Person.swift
//  TipNTop Snooker Parlour
//
//  Created by Dineshkumar on 11/05/15.
//  Copyright (c) 2015 TipNTop Cue Sports. All rights reserved.
//

import Foundation
import CoreData
@objc(Person)
class Person: NSManagedObject {

    @NSManaged var cost: NSNumber
    @NSManaged var name: String
    @NSManaged var paid: NSNumber
    @NSManaged var time: NSDate

}
