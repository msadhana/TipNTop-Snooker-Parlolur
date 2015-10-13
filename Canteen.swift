//
//  Canteen.swift
//  TipNTop Snooker Parlour
//
//  Created by Dineshkumar on 12/09/15.
//  Copyright (c) 2015 TipNTop Cue Sports. All rights reserved.
//

import Foundation
import CoreData
@objc(Canteen)
class Canteen: NSManagedObject {

    @NSManaged var item: String
    @NSManaged var quantity: NSNumber
    @NSManaged var price: NSNumber
    @NSManaged var code: String
    @NSManaged var totalprice: NSNumber
    
   
}
