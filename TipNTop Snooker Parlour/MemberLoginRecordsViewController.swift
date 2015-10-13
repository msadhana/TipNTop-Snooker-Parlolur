//
//  MemberLoginRecordsViewController.swift
//  TipNTop Snooker Parlour
//
//  Created by Dineshkumar on 23/07/15.
//  Copyright (c) 2015 TipNTop Cue Sports. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MemberLoginRecordsViewController  : UITableViewController {
    
    var member_name = NSString()
    var totalSales = 0.0
    var people = [Person]()
    
    override func  viewDidAppear(animated: Bool) {
        
        totalSales = 0.0
        println("Appeared")
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        let managedContext = appDelegate.managedObjectContext!
        
        
        println("Loaded")
        let fetchRequest = NSFetchRequest(entityName:"Person")
        var error: NSError?
        var predicate: NSPredicate = NSPredicate(format: "name == %@",member_name)
        fetchRequest.predicate =  predicate
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as! [Person]?
        
        if let results = fetchedResults {
            people = results
            println(people)
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        self.tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        totalSales = 0.0
        self.tableView.allowsMultipleSelectionDuringEditing = true
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.people.count + 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        var dateFormater = NSDateFormatter()
        
        dateFormater.timeZone = NSTimeZone()
        dateFormater.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormater.timeStyle = NSDateFormatterStyle.MediumStyle
        
        
        
        if(indexPath.row < (self.people.count)){
            println(indexPath.row)
            let str = "\(dateFormater.stringFromDate(self.people[indexPath.row].time))     \(people[indexPath.row].name)     \(people[indexPath.row].cost)"
            cell.textLabel?.text = str
            totalSales += people[indexPath.row].cost as Double
            println(totalSales)
        } else if (indexPath.row == (self.people.count)){
            let str = " Total = \(totalSales)"
            cell.textLabel?.text = str
            
        }
        
        return cell
        
    }
    
    
}