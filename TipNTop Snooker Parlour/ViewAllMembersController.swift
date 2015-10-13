//
//  ViewAllMembersController.swift
//  TipNTop Snooker Parlour
//
//  Created by Dineshkumar on 15/05/15.
//  Copyright (c) 2015 TipNTop Cue Sports. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class ViewAllMembersController : UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var searchActive : Bool = false
    
    var selected_member = NSNumber()
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        println("searchBarTextDidBeginEditing")
        searchActive = true;
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        println("searchBarTextDidEndEditing")
        
        searchActive = false;
        
        
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        println("searchBarCancelButtonClicked")
        searchActive = false;
        self.tableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        println("searchBarSearchButtonClicked")
        searchActive = true;
        self.tableView.reloadData()
    }
    func filterContentForSearchText(searchText: String) {
        // Filter the array using the filter method
        self.filteredMembers = member_list.filter({( member: Member) -> Bool in
            let stringMatch = member.name.rangeOfString(searchText)
            return (stringMatch != nil)
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
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        self.filteredMembers = member_list.filter({( member: Member) -> Bool in
            let stringMatch = member.name.rangeOfString(searchText)
            return (stringMatch != nil)
        })
        if(filteredMembers.count == 0){
            println("not found")
            searchActive = false;
        } else {
            println("found")
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    var members = [Member]()
    var filteredMembers = [Member]()
    var is_searching = false
    override func viewWillAppear(animated: Bool) {
        
        self.tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Member")
        var error: NSError?
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as! [Member]?
        
        
        if let results = fetchedResults {
            members = results
            member_list = results
            println(members)
            println("loading")
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        self.tableView.allowsMultipleSelectionDuringEditing = true
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete ) {
            //add code here for when you hit delete
            let appDelegate =
            UIApplication.sharedApplication().delegate as! AppDelegate
            
            
            let managedContext = appDelegate.managedObjectContext!
            
            //2
            let fetchRequest = NSFetchRequest(entityName:"Member")
            var error: NSError?
            
            
            var predicate =  NSPredicate ()
            
              if (searchActive)  {
               // managedContext.deleteObject(filteredMembers[indexPath.row])
                predicate  = NSPredicate(format: "memberid == \(filteredMembers[indexPath.row].memberid)")
                filteredMembers.removeAtIndex(indexPath.row)

              } else {
                //managedContext.deleteObject(member_list[indexPath.row])
                predicate  = NSPredicate(format: "memberid == \(member_list[indexPath.row].memberid)")
                member_list.removeAtIndex(indexPath.row)
                
            }
            
           // fetchRequest.predicate =  predicate
          
            let fetchedResults =
            managedContext.executeFetchRequest(fetchRequest,
                error: &error) as! [Member]?
            

            managedContext.deleteObject(fetchedResults![0])
            
         /*   if (searchActive) {
                filteredMembers.removeAtIndex(indexPath.row)
                
            } else {
            member_list.removeAtIndex(indexPath.row)
            
            }*/
            
            self.tableView!.beginUpdates()
            
            
            self.tableView!.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
          
            
           
           
            let fetchedResultsReload = managedContext.executeFetchRequest(fetchRequest,
                error: &error) as! [Member]?
            
            
            if  let results = fetchedResultsReload {
                members = results
                member_list = results
                println(members)
                println("loading")
            } else {
                println("Could not fetch \(error), \(error!.userInfo)")
            }
            self.tableView!.reloadData()
            self.tableView!.endUpdates()
            

            
            println("Deleted")
        }

        
    }
   
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (searchActive) {
            println("enabled")
            return self.filteredMembers.count
        } else {
            println("not enabled")
            return (member_list.count)
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(
            "memberDetailsViewCell", forIndexPath: indexPath) as! memberDetailsViewCell
      
        
        
        let row = indexPath.row
        
        if (searchActive)  {
            if(filteredMembers.count != 0){
                // person = filteredPerson[indexPath.row]
                println(indexPath.row)
                cell.membername.text = filteredMembers[row].name
                cell.memberid.text = "\(filteredMembers[row].memberid)"
                var str = ""
                
                cell.contact.text = filteredMembers[row].phoneno
                str = "\(filteredMembers[row].balance)"
                cell.Balance.text = str
            }
            
        } else {
            cell.membername.text = member_list[row].name
            cell.memberid.text = "\(member_list[row].memberid)"
            var str = ""
            
            cell.contact.text = member_list[row].phoneno
            str = "\(member_list[row].balance)"
            cell.Balance.text = str
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (searchActive) {
            println(filteredMembers[indexPath.row].name)
            selected_member = filteredMembers[indexPath.row].memberid
            memberid_value =  selected_member.integerValue
            println(filteredMembers[indexPath.row].memberid)
        } else {
            selected_member = member_list[indexPath.row].memberid
            println(" name \(member_list[indexPath.row].name)")
            memberid_value =  selected_member.integerValue
            println(member_list[indexPath.row].memberid)
        }
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        //   let destinationVC: UpdateMemberViewController = segue.destinationViewController as UpdateMemberViewController
        
        
        // println("selected_member \(selected_member)")
        //  println("dest \(destinationVC.memberid_value)")
        
        
    }
}