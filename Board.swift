//
//  Board.swift
//  
//
//  Created by Dineshkumar on 08/10/15.
//
//

import Foundation
import CoreData
@objc(Board)

class Board: NSManagedObject {

    @NSManaged var timeris_on: NSNumber
    @NSManaged var tableName: String

}
