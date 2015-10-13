//
//  Member.swift
//  TipNTop Snooker Parlour
//
//  Created by Dineshkumar on 11/05/15.
//  Copyright (c) 2015 TipNTop Cue Sports. All rights reserved.
//

import Foundation
import CoreData

@objc(Member)

public class Member: NSManagedObject {

    @NSManaged var addressproof: NSData
    @NSManaged var deposit: NSNumber
    @NSManaged var idproof: NSData
    @NSManaged var idtype: NSString
    @NSManaged var rank: NSNumber
    @NSManaged var points: NSNumber
    @NSManaged var name: String
    @NSManaged var personalphoto: NSData
    @NSManaged var playedcost: NSNumber
    @NSManaged var phoneno : String
    @NSManaged var email: String
    @NSManaged var balance: NSNumber
    @NSManaged var memberid: NSNumber

  
}
