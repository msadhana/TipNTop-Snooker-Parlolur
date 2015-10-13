//
//  RecordsViewController.swift
//  TipNTop Snooker Parlour
//
//  Created by Dineshkumar on 12/05/15.
//  Copyright (c) 2015 TipNTop Cue Sports. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class RecordViewController: UITableViewController , UISearchBarDelegate, UISearchDisplayDelegate {
    
    var people = [Person]()
    
    var totalSales = 0.0
    var Customername = ""
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var searchBar: UISearchBar!
    var filteredPerson = [Person]()
    
    
    
    @IBOutlet var segmentViewControl: UISegmentedControl!
    
    var searchActive : Bool = false
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        println("searchBarTextDidBeginEditing")
        searchActive = true;
        totalSales = 0.0
        
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        println("searchBarTextDidEndEditing")
        
        searchActive = false;
        
        
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        println("searchBarCancelButtonClicked")
        searchActive = false;
        totalSales = 0.0
        
        self.tableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        println("searchBarSearchButtonClicked")
        searchActive = true;
        totalSales = 0.0
        self.tableView.reloadData()
    }
    /* func filterContentForSearchText(searchText: String) {
    // Filter the array using the filter method
    self.filteredPerson = people.filter({( member: Person) -> Bool in
    let stringMatch = member.name.rangeOfString(searchText)
    return (stringMatch != nil)
    })
    }*/
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        self.filteredPerson = self.people.filter({( member : Person) -> Bool in
            var categoryMatch = (scope == "All") || (member.cost == 25)
            let stringMatch = member.name.rangeOfString(searchText)
            return categoryMatch && (stringMatch != nil)
        })
    }
    
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
    self.filterContentForSearchText(searchString)
    return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
    self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
    
    return true
    }
    
    /* func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchString searchString: String!) -> Bool {
    let scopes = self.searchDisplayController.searchBar.scopeButtonTitles as [String]
    let selectedScope = scopes[self.searchDisplayController.searchBar.selectedScopeButtonIndex] as String
    self.filterContentForSearchText(searchString, scope: selectedScope)
    return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController!, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
    let scope = self.searchDisplayController.searchBar.scopeButtonTitles as [String]
    self.filterContentForSearchText(self.searchDisplayController.searchBar.text, scope: scope[searchOption])
    return true
    }
    */
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        /*self.filteredPerson = people.filter({( member: Person) -> Bool in
        let stringMatch = member.name.rangeOfString(searchText)
        return (stringMatch != nil)
        })*/
        var choice = NSNumber()
        if searchBar.selectedScopeButtonIndex == 0 {
            choice = 25
        } else {
            choice = 50
        }
        println("choice \(choice)")
        self.filteredPerson = self.people.filter({( member : Person) -> Bool in
            var categoryMatch =  (member.cost ==  choice)
            let stringMatch = member.name.rangeOfString(searchText)
            return categoryMatch && (stringMatch != nil)
        })
        
        if(filteredPerson.count == 0){
            println("not found")
            searchActive = false;
        } else {
            println("found")
            searchActive = true;
        }
        totalSales = 0.0
        self.tableView.reloadData()
    }
    
    // @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        totalSales = 0.0
        println("Appeared")
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        println("Loaded")
        let fetchRequest = NSFetchRequest(entityName:"Person")
        var error: NSError?
        if( Customername != ""){
            var predicate: NSPredicate = NSPredicate(format: "name == %@",Customername)
            fetchRequest.predicate =  predicate
        }
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as! [Person]?
        
        // fetchedResults?.filter(name == "Sadhana")
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
        //searchBar.delegate = self
        totalSales = 0.0
        self.tableView.allowsMultipleSelectionDuringEditing = true
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if searchActive {
            println("enabled \(self.filteredPerson.count + 1)")
            return (self.filteredPerson.count + 1)
        } else {
            println("not enabled \(self.people.count + 1)")
            return (self.people.count + 1)
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! UITableViewCell
        
        var dateFormater = NSDateFormatter()
        
        dateFormater.timeZone = NSTimeZone()
        dateFormater.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormater.timeStyle = NSDateFormatterStyle.MediumStyle
        
        
        if searchActive {
            if(filteredPerson.count != 0){
                
                if(indexPath.row < (self.filteredPerson.count)) {
                    println(indexPath.row)
                    let str = "\(dateFormater.stringFromDate(self.filteredPerson[indexPath.row].time))     \(filteredPerson[indexPath.row].name)     \(filteredPerson[indexPath.row].cost)"
                    
                    cell.textLabel?.text = str
                    println("total sales before:\(totalSales)")
                    totalSales += filteredPerson[indexPath.row].cost as Double
                    println("total sales after:\(totalSales)")
                } else if (indexPath.row == (self.filteredPerson.count)){
                    let str = " Total = \(totalSales)"
                    cell.textLabel?.text = str
                    println("total sales end:\(totalSales)")
                    
                }
            }
        } else {
            if(indexPath.row < (self.people.count)){
                println(indexPath.row)
                let str = "\(dateFormater.stringFromDate(self.people[indexPath.row].time))     \(people[indexPath.row].name)     \(people[indexPath.row].cost)"
                println("date\(self.people[indexPath.row].time)")
                cell.textLabel?.text = str
                totalSales += people[indexPath.row].cost as Double
                println(totalSales)
            } else if (indexPath.row == (self.people.count)){
                let str = " Total = \(totalSales)"
                cell.textLabel?.text = str
                
            }
            
        }
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete ) {
            //add code here for when you hit delete
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            
            
            let managedContext = appDelegate.managedObjectContext!
            
            //2
            let fetchRequest = NSFetchRequest(entityName:"Person")
            var error: NSError?
            
            let fetchedResults =
            managedContext.executeFetchRequest(fetchRequest,
                error: &error) as! [NSManagedObject]?
            
            managedContext.deleteObject(self.people[indexPath.row])
            
            
            self.people.removeAtIndex(indexPath.row)
            
            
            
            self.tableView!.beginUpdates()
            
            
            self.tableView!.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            self.totalSales = 0
            self.tableView!.reloadData()
            self.tableView!.endUpdates()
            
            
            println("Deleted")
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
    func notifyUser(title: String, message: String) -> Void
    {
        let alert = UIAlertController(title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.Alert)
        
        let cancelAction = UIAlertAction(title: "OK",
            style: .Cancel, handler: nil)
        
        alert.addAction(cancelAction)
        self.presentViewController(alert, animated: true,
            completion: nil)
    }
    
}




