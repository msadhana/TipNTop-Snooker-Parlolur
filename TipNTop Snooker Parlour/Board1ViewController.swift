//
//  Board1ViewController.swift
//  TipNTop Snooker Parlour
//
//  Created by Dineshkumar on 11/05/15.
//  Copyright (c) 2015 TipNTop Cue Sports. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import AVFoundation

public  func popupAlert(alert: NSString, viewController: UIViewController) {
    var alert1 = UIAlertController(title: alert as String,
        message: " ",
        preferredStyle: .Alert)
    
    let cancelAction = UIAlertAction(title: "Ok",
        style: .Default) { (action: UIAlertAction!) -> Void in
            alert1.dismissViewControllerAnimated(true, completion: nil)
            
    }
    
    alert1.addAction(cancelAction)
    
    viewController.presentViewController(alert1,
        animated: true,
        completion: nil)
    
}
public class foodBill {
     var item: String
     var quantity: NSNumber
     var price: NSNumber
     var code: String
     var totalprice: NSNumber
    
    init() {
      item = ""
    quantity = 0
    price = 0.0
        code = ""
        totalprice = 0.0
    }

}

public class Board {
    var isStarted: Bool = false
    var name1: String = ""
    var name2: String = ""
    var startTime = NSTimeInterval()
    var amount = UInt16()
    var elapsedTime = NSTimeInterval()
    var done: Bool = true
    var totalCost = UInt16()
    var foodCost = Float()
    var paid = UInt16()
    var haspaid :Bool = true
    var gameType = Int()
    var gameTypeSelected: Bool = false
    var payee = Int()
    var winnerSelected = false
    var BillSummary: NSString = ""
    var boardcharge = UInt16()
    var hour = UInt16()
    var minutes = UInt16()
    var discount = NSString()
    var startTimeString = ""
    var endTimeString = ""
    var foodCharges = [foodBill]()
    var totalp = Float()
    var totalq = Int16()
    init() {
        isStarted = false
        name1 = ""
        name2 = ""
        startTime = NSTimeInterval()
        amount = UInt16()
        elapsedTime = NSTimeInterval()
        done = true
        totalCost = UInt16()
        foodCost = Float()
        paid = UInt16()
        haspaid = true
        gameType = Int()
        gameTypeSelected = false
        payee = Int()
        winnerSelected = false
        BillSummary = ""
        boardcharge = UInt16()
        
    }
    
    func free(board: Board) {
        board.isStarted = false
        board.name1 = ""
        board.name2 = ""
        board.startTime = NSTimeInterval()
        board.amount = UInt16()
        board.elapsedTime = NSTimeInterval()
        board.done = true
        board.totalCost = UInt16()
        board.foodCost = Float()
        board.paid = UInt16()
        board.haspaid = true
        board.gameType = Int()
        board.gameTypeSelected = false
        board.payee = Int()
        board.winnerSelected = false
        board.BillSummary = ""
        board.boardcharge = UInt16()
        
    }
}
public class BoardManager {
    
    class var sharedInstance: BoardManager {
        
        struct Static {
            static let instance: BoardManager = BoardManager()
        }
        return Static.instance
    }
    
    public var board1 = Board()
    public var board2 = Board()
    public var board3 = Board()
    public var board4 = Board()
    public var cost = UInt16(2.5)
    public var pdcode = 1
    public var password = "gdine89"
    
}

class Board1ViewController : UIViewController, UIPickerViewDelegate , UIPickerViewDataSource, UITextFieldDelegate, AVCaptureMetadataOutputObjectsDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var player1Name: UITextField!
    
    @IBOutlet weak var player2Name: UITextField!
    
    @IBOutlet weak var boardCharge: UITextField!
    
    @IBOutlet weak var foodCost: UITextField!
    
    @IBOutlet weak var totalCost: UITextField!
    
    @IBOutlet weak var amountPaid: UITextField!
    
    @IBOutlet weak var Balance: UITextField!
    
    @IBOutlet weak var timerDisplay: UITextField!
    
    @IBOutlet weak var memberid1: UITextField!
    
    @IBOutlet weak var memberid2: UITextField!
    
    @IBOutlet weak var paidButton: UIButton!
    
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var refreshbutton: UIButton!
    
      @IBOutlet weak var picker: UIPickerView!
    
    @IBOutlet weak var player1label: UILabel!
    
    @IBOutlet weak var gameType: UITextField!
    
    @IBOutlet weak var win: UITextField!
    
    @IBOutlet weak var billVIew: UIImageView!
    @IBOutlet weak var timerStartStop: UIButton!
    
    @IBOutlet weak var scan1: UIButton!
    
    @IBOutlet weak var scan2: UIButton!
    
    var game = ["Loser Pay", "Single", "Split"]
    
    @IBOutlet weak var discount: UITextField!
    
    @IBOutlet weak var printButton: UIButton!
    @IBOutlet weak var discountPicker: UIPickerView!
    var discounts = ["","Happy hours",""]
    @IBAction func cancelQRcode(sender: AnyObject) {
        
        captureSession?.stopRunning()
        videoPreviewLayer?.removeFromSuperlayer()
        
        qrCodeFrameView?.removeFromSuperview()
        
        

    }
    
    var Winner = [0,1,2]
    
    override func viewDidLoad() {
        startOfMonth()
        if(BoardManager.sharedInstance.board1.isStarted == true && BoardManager.sharedInstance.board1.done == false ){
            boardCharge.text = NSString(format: "%u.00", BoardManager.sharedInstance.board1.boardcharge) as String
            self.foodCost.text = NSString(format: "%u.00", BoardManager.sharedInstance.board1.foodCost) as String
            player1Name.text = BoardManager.sharedInstance.board1.name1
            player2Name.text = BoardManager.sharedInstance.board1.name2
            
            
            timerStartStop.setTitle("Stop", forState: UIControlState.Normal)
            
            timerStartStop.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
            
            
            let aSelector : Selector = "updateTime"
            NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: aSelector, userInfo: nil, repeats: true)
        }
        
        if((BoardManager.sharedInstance.board1.isStarted == false && BoardManager.sharedInstance.board1.done == false) ||
            (BoardManager.sharedInstance.board1.isStarted == false && BoardManager.sharedInstance.board1.done == true && BoardManager.sharedInstance.board1.haspaid == false)){
                
                player1Name.text = BoardManager.sharedInstance.board1.name1
                player2Name.text = BoardManager.sharedInstance.board1.name2
                self.foodCost.text = NSString(format: "%u.00", BoardManager.sharedInstance.board1.foodCost) as String
                
                totalCost.text = NSString(format: "%u.00", BoardManager.sharedInstance.board1.totalCost)
          as String
                var currentTime = NSDate.timeIntervalSinceReferenceDate()
                
                
                // Find difference between current time and start time
                BoardManager.sharedInstance.board1.elapsedTime = currentTime - BoardManager.sharedInstance.board1.startTime
                
                // Calculate minutes in elapsed time
                var hours = UInt16(BoardManager.sharedInstance.board1.elapsedTime/3600.0)
                BoardManager.sharedInstance.board1.elapsedTime -= (NSTimeInterval(hours)*3600)
                var minutes = UInt16(BoardManager.sharedInstance.board1.elapsedTime/60.0)
                
                BoardManager.sharedInstance.board1.elapsedTime -= (NSTimeInterval(minutes)*60)
                
                var seconds = UInt16(BoardManager.sharedInstance.board1.elapsedTime)
                BoardManager.sharedInstance.board1.elapsedTime -= NSTimeInterval(seconds)
                
                timerDisplay.text = NSString(format: "%02u:%02u:%02u", hours,minutes,seconds) as String
                
                
                boardCharge.text = NSString(format: "%u.00",BoardManager.sharedInstance.board1.boardcharge) as String
                
                
        }
        paidButton.backgroundColor = UIColor.blueColor()
        paidButton.layer.cornerRadius = 15
        paidButton.layer.shadowRadius = 15
        paidButton.layer.shadowOffset = CGSize(width: 15, height: 15)
        paidButton.layer.shadowOpacity = 1
        
        doneButton.backgroundColor = UIColor.blueColor()
        doneButton.layer.cornerRadius = 15
        doneButton.layer.shadowRadius = 15
        doneButton.layer.shadowOffset = CGSize(width: 15, height: 15)
        doneButton.layer.shadowOpacity = 1
        
        refreshbutton.backgroundColor = UIColor.blueColor()
        refreshbutton.layer.cornerRadius = 15
        refreshbutton.layer.shadowRadius = 15
        refreshbutton.layer.shadowOffset = CGSize(width: 15, height: 15)
        refreshbutton.layer.shadowOpacity = 1
        
        timerStartStop.backgroundColor = UIColor.whiteColor()
        timerStartStop.layer.cornerRadius = 15
        timerStartStop.layer.shadowRadius = 15
        timerStartStop.layer.shadowOffset = CGSize(width: 15, height: 15)
        timerStartStop.layer.shadowOpacity = 1
        
        picker.hidden = true
        win.delegate = self
        win.inputView = picker
        
        gameType.delegate = self
        gameType.inputView = picker
        
        discountPicker.hidden = true
        discount.delegate = self
        discount.inputView = discountPicker
        
        printButton.hidden = true
        
        canteen = []
        canteenItems.hidden = true
        newItem.delegate = self
        newItem.inputView = canteenPicker
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    
    
    
    @IBAction func editingDidEndforTextFields(sender: AnyObject) {
        
        
        switch sender.tag {
        case 0 :
            println("Cusomter 1 name \(player1Name.text)")
            BoardManager.sharedInstance.board1.name1 = player1Name.text
            
            break
        case 1 :
            println("Customer 2 Name \(player2Name.text)")
            BoardManager.sharedInstance.board1.name2 = player2Name.text
            break
        default:
            break
            
        }
    }
    
    
    @IBAction func startStop(sender: AnyObject) {
        
        var dateFormater = NSDateFormatter()
        
        dateFormater.timeZone = NSTimeZone()
        dateFormater.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormater.timeStyle = NSDateFormatterStyle.MediumStyle

        
        if(BoardManager.sharedInstance.board1.isStarted == false){
            BoardManager.sharedInstance.board1.isStarted = true
            BoardManager.sharedInstance.board1.done = false
            BoardManager.sharedInstance.board1.haspaid = false
            boardCharge.text = "50.00"
            sender.setTitle("Stop", forState: UIControlState.Normal)
            BoardManager.sharedInstance.board1.totalCost = 0
            BoardManager.sharedInstance.board1.amount = 0
            BoardManager.sharedInstance.board1.foodCost = 0
            BoardManager.sharedInstance.board1.startTime = NSDate.timeIntervalSinceReferenceDate()
            BoardManager.sharedInstance.board1.startTimeString = "\(dateFormater.stringFromDate(NSDate()))"
            BoardManager.sharedInstance.board1.name1 = player1Name.text
            BoardManager.sharedInstance.board1.name2 = player2Name.text
            
            tableUsage.sharedInstance.usage[0] = "Playing"
            
            let aSelector : Selector = "updateTime"
            
            NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: aSelector, userInfo: nil, repeats: true)
            
        } else {
            BoardManager.sharedInstance.board1.isStarted  = false
            timerStartStop.setTitle("Start", forState: UIControlState.Normal)
            timerStartStop.setTitleColor(UIColor.greenColor(), forState: UIControlState.Normal)
            
            BoardManager.sharedInstance.board1.name1 = player1Name.text
            BoardManager.sharedInstance.board1.name2 = player2Name.text
            
             BoardManager.sharedInstance.board1.endTimeString = "\(dateFormater.stringFromDate(NSDate()))"
        }
    }
    
    
    func updateTime(){
        
        if ( BoardManager.sharedInstance.board1.isStarted == false){
            return
        }
        var currentTime = NSDate.timeIntervalSinceReferenceDate()
        
        
        // Find difference between current time and start time
        BoardManager.sharedInstance.board1.elapsedTime = currentTime - BoardManager.sharedInstance.board1.startTime
        
        // Calculate minutes in elapsed time
        var hours = UInt16(BoardManager.sharedInstance.board1.elapsedTime/3600.0)
        BoardManager.sharedInstance.board1.elapsedTime -= (NSTimeInterval(hours)*3600)
        var minutes = UInt16(BoardManager.sharedInstance.board1.elapsedTime/60.0)
        
        BoardManager.sharedInstance.board1.elapsedTime -= (NSTimeInterval(minutes)*60)
        
        var seconds = UInt16(BoardManager.sharedInstance.board1.elapsedTime)
        BoardManager.sharedInstance.board1.elapsedTime -= NSTimeInterval(seconds)
        
        timerDisplay.text = NSString(format: "%02u:%02u:%02u", hours,minutes,seconds) as String
        boardCharge.text = NSString(format: "%u.00", BoardManager.sharedInstance.board1.amount) as String
        if( minutes <= 20){
            BoardManager.sharedInstance.board1.amount = 50
        } else {
            BoardManager.sharedInstance.board1.amount = (hours * 60 * 3)+(minutes * BoardManager.sharedInstance.cost)
        }
        BoardManager.sharedInstance.board1.hour = hours
        BoardManager.sharedInstance.board1.minutes = minutes
        
    }
    
    
    @IBAction func Paid(sender: AnyObject) {
        if (BoardManager.sharedInstance.board1.done == false ){
            popupAlert("Please calculate total Cost!!",self)
            return
            
        }
        println(BoardManager.sharedInstance.board1.done)
        
        
        if (amountPaid.text == "" ){
            popupAlert("Please enter amount Paid!!",self)
            return
            
        }
        BoardManager.sharedInstance.board1.paid = UInt16((amountPaid.text as NSString).intValue)
        
        Balance.text = NSString(format: "%u.00", (BoardManager.sharedInstance.board1.paid - BoardManager.sharedInstance.board1.totalCost)) as String
        
       
        var date = NSDate()
        var dateFormater = NSDateFormatter()
        dateFormater.timeZone = NSTimeZone()
        dateFormater.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormater.timeStyle = NSDateFormatterStyle.MediumStyle
        
        
        
        UIGraphicsBeginImageContext(billVIew.frame.size)
        
        
        
        
        var text = NSString(format: "                Tip N Top\n    Insaff Complex,Birds Road,Trichy-1\n==================================\nDate & TIme: \(dateFormater.stringFromDate(date))\nCustomer Name:\(player1Name.text),\(player2Name.text) \nDuration:\(timerDisplay.text)\nTable No: 1\nTime Start:\(BoardManager.sharedInstance.board1.startTimeString )\nTime End:\(BoardManager.sharedInstance.board1.endTimeString )\nTotal= \(totalCost.text)\nThank You Have a Great Day!!!")
        var textColor: UIColor = UIColor.blackColor()
        var textFont: UIFont = UIFont(name: "CopperPlate", size: 13)!
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
        ]
        
        text.drawInRect(CGRect(x: 30,y: 30,width: billVIew.frame.width,height: billVIew.frame.height), withAttributes: textFontAttributes)
        
        var imageto = UIGraphicsGetImageFromCurrentImageContext()
        
        billVIew.image = imageto
        UIGraphicsEndImageContext();
        
        saveData()
        printButton.hidden = false
        
        
    }
    func writeToCore(name:NSString, paid: NSNumber, cost: NSNumber) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext! as NSManagedObjectContext
        
        let user = NSEntityDescription.insertNewObjectForEntityForName("Person", inManagedObjectContext: managedContext) as! Person
       
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .MediumStyle)
        
        //NSDateFormatter.
        
        user.setValue(name, forKey: "name")
        
       
        
        user.setValue(NSDate(),forKey: "time")
        user.setValue(cost, forKey: "cost")
        user.setValue(paid, forKey: "paid")
        
        managedContext.save(nil)
        
        
        println(user.name)
        calculateTime()
        
        println("Object Saved")
        
    }
    
    func updateMemberDetails(memberid: Int, cost: NSNumber) {
        
        var members = [Member]()
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        let managedContext = appDelegate.managedObjectContext!
        println("id# \(memberid)")
        let fetchRequest = NSFetchRequest(entityName:"Member")
        var predicate: NSPredicate = NSPredicate(format: "memberid == \(memberid)")
        fetchRequest.predicate =  predicate
        var error: NSError?
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as! [Member]?
        
        
        if let results = fetchedResults {
            
            if (results.count != 0){
                var managedObject = results[0]
                
                println("name: \(results[0].memberid)")
                
                var final_update = Int()
                
                final_update = results[0].balance.integerValue -  cost.integerValue
                println("name1 : \(results[0].name) balance1 \(results[0].balance)")
                
                results[0].balance = NSNumber(integer: final_update)
                
                println("name : \(results[0].name) balance \(results[0].balance)")
                
                println("Found")
                println(members)
                
                managedContext.save(nil)
            }
            
        } else {
            popupAlert("Member ID not appropriate!!!",self)
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
    }
    
    
    @IBAction func refresh(sender: AnyObject) {
        BoardManager.sharedInstance.board1.free(BoardManager.sharedInstance.board1)
        initComponents()
    }
    
    
    func saveData(){
        var issplit = false
        var paid = NSNumber()
        var name :NSString = ""
        var cost = NSNumber()
        var memberid = Int()
        
        switch BoardManager.sharedInstance.board1.gameType
        {
        case 0:
            if(!BoardManager.sharedInstance.board1.winnerSelected){
                popupAlert("Please select winner",self)
                return
            }
            if(BoardManager.sharedInstance.board1.payee == 1) {
                name = player1Name.text
                if (memberid1.text != "") {
                    memberid =  (memberid1.text as NSString).integerValue
                    println("id# \(memberid)")
                }
            } else {
                name = player2Name.text
                if (memberid2.text != "") {
                    memberid = (memberid2.text as NSString).integerValue
                    println("id# \(memberid)")
                }
            }
            paid = NSNumber(unsignedShort: BoardManager.sharedInstance.board1.paid)
            cost = NSNumber(unsignedShort: BoardManager.sharedInstance.board1.totalCost)
            break
        case 1:
            if(!BoardManager.sharedInstance.board1.winnerSelected){
                popupAlert("Please select payee!!",self)
                return
            }
            if(BoardManager.sharedInstance.board1.payee == 1) {
                name = player1Name.text
                if (memberid1.text != "") {
                    memberid = (memberid1.text as NSString).integerValue
                    println("id# \(memberid)")
                }
            } else {
                name = player2Name.text
                if (memberid2.text != "") {
                    memberid = (memberid2.text as NSString).integerValue
                    println("id# \(memberid)")
                }
            }
            
            paid = NSNumber(unsignedShort: BoardManager.sharedInstance.board1.paid)
            cost = NSNumber(unsignedShort: BoardManager.sharedInstance.board1.totalCost)
            break
        case 2:
            
            name = player1Name.text
            if (memberid1.text != "") {
                memberid = (memberid1.text as NSString).integerValue
                println("id# \(memberid)")
            }
            paid = NSNumber(unsignedShort: BoardManager.sharedInstance.board1.paid/2)
            cost = NSNumber(unsignedShort: BoardManager.sharedInstance.board1.totalCost/2)
            issplit = true
            break
        default:
            break
            
        }
        
        
        writeToCore(name, paid: paid, cost: cost)
        
        println("id#  final \(memberid)")
        if memberid != 0 {
            updateMemberDetails(memberid, cost: paid)
        }
        if(issplit) {
            name = player2Name.text
            memberid = (memberid2.text as NSString).integerValue
            if memberid != 0 {
                updateMemberDetails(memberid, cost: paid)
                
            }
            writeToCore(name, paid: paid, cost: cost)
            
        }
        BoardManager.sharedInstance.board1.haspaid = true
        issplit = false
        
    }
    
    
    
    @IBAction func done(sender: AnyObject) {
        if(player1Name.text == "" && player2Name.text == ""){
            popupAlert("Please enter name customer name",self)
            return
        }
        if ( BoardManager.sharedInstance.board1.isStarted == true){
            
            popupAlert("Please stop timer first!!",self)
            
            return
        }
        if (!BoardManager.sharedInstance.board1.gameTypeSelected) {
            popupAlert("Please select game type!!",self)
            
            return
        }
        var discount_amount = UInt16(0)
        if(discount.text == "Happy hours") {
            if BoardManager.sharedInstance.board1.hour > 1 {
                discount_amount = (BoardManager.sharedInstance.board1.hour/2 ) * 60 *  BoardManager.sharedInstance.cost
                
            } else if BoardManager.sharedInstance.board1.hour == 1 {
                discount_amount = BoardManager.sharedInstance.board1.minutes * BoardManager.sharedInstance.cost
            }
            
        }
        
        BoardManager.sharedInstance.board1.totalCost = BoardManager.sharedInstance.board1.amount + UInt16(BoardManager.sharedInstance.board1.foodCost) - discount_amount
        println("Food cost in UInt \(UInt16(BoardManager.sharedInstance.board1.foodCost))")
        println(BoardManager.sharedInstance.board1.amount)
        totalCost.text = NSString(format: "%u.00", BoardManager.sharedInstance.board1.totalCost) as String
        BoardManager.sharedInstance.board1.name1 = player1Name.text
        BoardManager.sharedInstance.board1.name2 = player2Name.text
        BoardManager.sharedInstance.board1.done = true
        
        switch BoardManager.sharedInstance.board1.gameType
        {
        case 0:
            if(!BoardManager.sharedInstance.board1.winnerSelected){
                popupAlert("Please select winner",self)
                return
            }
            if(BoardManager.sharedInstance.board1.payee == 1) {
                BoardManager.sharedInstance.board1.BillSummary = "Bill of Rs.\(BoardManager.sharedInstance.board1.totalCost) to be paid by \(player1Name.text) "
                
            } else {
                BoardManager.sharedInstance.board1.BillSummary = "Bill of Rs.\(BoardManager.sharedInstance.board1.totalCost) to be paid by \(player2Name.text)"
            }
            
            break
        case 1:
            if(!BoardManager.sharedInstance.board1.winnerSelected){
                popupAlert("Please select payee!!",self)
                return
            }
            if(BoardManager.sharedInstance.board1.payee == 1) {
                BoardManager.sharedInstance.board1.BillSummary = "Bill of Rs.\(BoardManager.sharedInstance.board1.totalCost) to be paid by \(player1Name.text)"
                
            } else {
                BoardManager.sharedInstance.board1.BillSummary = "Bill of Rs.\(BoardManager.sharedInstance.board1.totalCost) to be paid by \(player2Name.text)"
            }
            break
        case 2:
            BoardManager.sharedInstance.board1.BillSummary = "Bill of Rs.\(BoardManager.sharedInstance.board1.totalCost) to be paid by \(player1Name.text) and \(player2Name.text) split by Rs.\(BoardManager.sharedInstance.board1.totalCost/2) each"
            break
        default:
            break
            
        }
        println(BoardManager.sharedInstance.board1.BillSummary)
        
    }
    func initComponents() {
        player1Name.text = nil
        player2Name.text = nil
        totalCost.text = nil
        boardCharge.text = nil
        foodCost.text = nil
        totalCost.text = nil
        amountPaid.text = nil
        Balance.text = nil
        timerDisplay.text = nil
        tableUsage.sharedInstance.usage[0] = "Free"
        printButton.hidden = true
        BoardManager.sharedInstance.board1.foodCharges = []
        
    }
    
    @IBAction func printBill(sender: AnyObject) {
        let printController = UIPrintInteractionController.sharedPrintController()!
        let printInfo = UIPrintInfo(dictionary:nil)!
        printInfo.outputType = UIPrintInfoOutputType.Photo
        printInfo.jobName = "print Job"
        printController.printInfo = printInfo
        
        printController.printingItem = billVIew.image
        
     //   printController.printFormatter.contentInsets = UIEdgeInsets(top: 72, left: 72, bottom: 72, right: 72)
        
        printController.presentFromRect(CGRect(origin: CGPoint(x: 0, y: 0), size: billVIew.image!.size), inView: self.view, animated: true, completionHandler: nil)

        
      /*  let formatter = UIMarkupTextPrintFormatter(markupText: "       Tip N Top     \n=========================")
        // formatter.contentInsets = UIEdgeInsets(top: 72, left: 72, bottom: 72, right: 72)
        printController.printFormatter = formatter
        
        // 4
        // printController.presentAnimated(true, completionHandler: nil)
        printController.presentFromRect(sender.frame, inView: self.view, animated: true, completionHandler: nil)*/
        
    }
    override func didMoveToParentViewController(parent: UIViewController?) {
        if (!(parent?.isEqual(self.parentViewController) ?? false)) {
            println("Back Button Pressed!")
        }
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView.tag == 0 {
            if component == 0 {
                return game.count
            }
            else {
                return Winner.count
        } } else if pickerView.tag == 1 {
            return discounts.count
        } else {
            println("count \(canteen.count)")
            return canteen.count
            
        }
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        if pickerView.tag == 0 {
            return 2
        } else  {
            return 1
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        println("tag picker \(pickerView.tag)")
        if pickerView.tag  == 0 {
            if component == 0 {
                return  game[row]
            } else {
                return NSString(format: "%u", Winner[row]) as String
            }
        } else if pickerView.tag == 1 {
            return discounts[row]
        } else {
               return "\(canteen[row].item) - Rs.\(canteen[row].price)"
           
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        if pickerView.tag == 0 {
            
            if component == 0 {
                
                gameType.text = game[row]
                switch row
                {
                case 0:
                    BoardManager.sharedInstance.board1.gameType = 0
                    BoardManager.sharedInstance.board1.gameTypeSelected = true
                    println("0")
                    break
                case 1:
                    BoardManager.sharedInstance.board1.gameType = 1
                    BoardManager.sharedInstance.board1.gameTypeSelected = true
                    println("1")
                    break
                case 2:
                    BoardManager.sharedInstance.board1.gameType = 2
                    BoardManager.sharedInstance.board1.gameTypeSelected = true
                    println("2")
                    break
                    
                default :
                    BoardManager.sharedInstance.board1.gameType = -1
                    println("default")
                    break
                    
                }
                
            } else {
                
                win.text = "\(Winner[row])"
                switch row
                {
                case 0:
                    BoardManager.sharedInstance.board1.winnerSelected = true
                    BoardManager.sharedInstance.board1.payee = 1
                    break
                case 1:
                    BoardManager.sharedInstance.board1.winnerSelected = true
                    BoardManager.sharedInstance.board1.payee = 2
                    break
                default:
                    break
                }
                
                println("Game type")
                picker.hidden = true;
            }
        } else if pickerView.tag == 1 {
            println("Discounts")
            discount.text = discounts[row]
            BoardManager.sharedInstance.board1.discount = "Happy hours"
            discountPicker.hidden = true
        } else {
            newItem.text = "\(canteen[row].item) - Rs.\(canteen[row].price)"
            availableQ.text = "\(canteen[row].quantity)"
            canteenPicker.hidden = true
            itemChosen = row
           }
    }
    
    var itemChosen = Int()
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if textField.tag == 2 {
            
            discountPicker.hidden = false
            picker.hidden = true
            
        } else if textField.tag == 0 {
            
            picker.hidden = false
            discountPicker.hidden = true
            
            
        } else if textField.tag == 1 {
            
            picker.hidden = false
            discountPicker.hidden = true
            
            
        } else if textField.tag == 3 {
            canteenPicker.hidden = false
            
        }
        
        return false
        
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        let pickerLabel = UILabel()
        var titleData = ""
        if pickerView.tag == 0 {
            
            
            if component == 0 {
                titleData = game[row]
            } else {
                titleData = "\(Winner[row])"
            }
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
            pickerLabel.attributedText = myTitle
            let hue = CGFloat(row)/CGFloat(game.count)
            pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 0.90, brightness:1.0, alpha: 0.5)
            pickerLabel.textAlignment = .Center
        }
        else if pickerView.tag == 1 {
            
            titleData = discounts[row]
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
            pickerLabel.attributedText = myTitle
            let hue = CGFloat(row)/CGFloat(discounts.count)
            pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 0.90, brightness:1.0, alpha: 0.5)
            pickerLabel.textAlignment = .Center
            
            
        } else {
            println("row \(row)")
            titleData = "\(canteen[row].item) - Rs.\(canteen[row].price)"
            let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
            pickerLabel.attributedText = myTitle
            let hue = CGFloat(row)/CGFloat(canteen.count)
            pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 0.90, brightness:1.0, alpha: 0.5)
            pickerLabel.textAlignment = .Center
            
            

        }
        
        return pickerLabel
    }
    
    func updateCustomerName(playerNo: Int) {
        let appDelegate =
        UIApplication.sharedApplication().delegate as!AppDelegate
        
        var members = [Member]()
        
        var memberid_value = Int32()
        

        if playerNo == 0 {
            
            memberid_value = (memberid1.text as NSString).intValue
            
        } else {
            
            memberid_value = (memberid2.text as NSString).intValue
            
        }
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Member")
        
        var predicate: NSPredicate = NSPredicate(format: "memberid == \(memberid_value)")
        fetchRequest.predicate =  predicate
        var error: NSError?
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,error: &error) as! [Member]?
        
        
        if let results = fetchedResults {
            
            if (results.count != 0){
                var managedObject = results[0]
                
                println("name: \(results[0].memberid)")
                
                
                println("name : \(results[0].name) balance \(results[0].balance)")
                
                println("Found")
                
                if playerNo == 0 {
                    player1Name.text = results[0].name
                    BoardManager.sharedInstance.board1.name1 = player1Name.text
                } else {
                    player2Name.text = results[0].name
                    BoardManager.sharedInstance.board1.name2 = player2Name.text
                }
                
            } else {
                popupAlert("Please Enter Valid MemberID!!",self)
            }
            
        }


    }
    
    @IBAction func member_id_editing_ended(sender: AnyObject) {
        
        if sender.tag == 0 {
        updateCustomerName(0)
        } else {
            updateCustomerName(1)
        }
        
    }
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    // Added to support different barcodes
    let supportedBarCodes = [AVMetadataObjectTypeQRCode, AVMetadataObjectTypeCode128Code, AVMetadataObjectTypeCode39Code, AVMetadataObjectTypeCode93Code, AVMetadataObjectTypeUPCECode, AVMetadataObjectTypePDF417Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeAztecCode]

    var playerToScan = 0
    
    @IBAction func scanCard(sender: AnyObject) {
        
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        
        // Get an instance of the AVCaptureDeviceInput class using the previous device object.
        var error:NSError?
        let input: AnyObject! = AVCaptureDeviceInput.deviceInputWithDevice(captureDevice, error: &error)
        
        if (error != nil) {
            // If any error occurs, simply log the description of it and don't continue any more.
            println("\(error?.localizedDescription)")
            return
        }
        
        // Initialize the captureSession object.
        captureSession = AVCaptureSession()
        // Set the input device on the capture session.
        captureSession?.addInput(input as! AVCaptureInput)
        
        // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetadataOutput)
        
        // Set delegate and use the default dispatch queue to execute the call back
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        captureMetadataOutput.metadataObjectTypes = supportedBarCodes
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        
        videoPreviewLayer?.frame = CGRect(x: sender.frame.origin.x - 330, y: sender.frame.origin.y, width: 300, height: 300)
        
        if sender.tag == 0 {
            playerToScan = 0
        } else {
            playerToScan = 1
        }
        view.layer.addSublayer(videoPreviewLayer)
        
        // Start video capture.
        captureSession?.startRunning()
        
        // Move the message label to the top view
       // view.bringSubviewToFront(messageLabel)
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        qrCodeFrameView?.layer.borderColor = UIColor.greenColor().CGColor
        qrCodeFrameView?.layer.borderWidth = 2
        view.addSubview(qrCodeFrameView!)
        view.bringSubviewToFront(qrCodeFrameView!)
        
        println("Cancel button")
        

    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRectZero
           // messageLabel.text = "No QR code is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        // Here we use filter method to check if the type of metadataObj is supported
        // Instead of hardcoding the AVMetadataObjectTypeQRCode, we check if the type
        // can be found in the array of supported bar codes.
        if supportedBarCodes.filter({ $0 == metadataObj.type }).count > 0 {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(metadataObj as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = barCodeObject.bounds
            
            if metadataObj.stringValue != nil {
               // messageLabel.text = metadataObj.stringValue
                // launchApp(metadataObj.stringValue)
                if playerToScan == 0 {
                memberid1.text = metadataObj.stringValue
                updateCustomerName(0)
                } else {
                    memberid2.text = metadataObj.stringValue
                    updateCustomerName(1)
                    
                }
                // return
                captureSession?.stopRunning()
                videoPreviewLayer?.removeFromSuperlayer()
                qrCodeFrameView?.removeFromSuperview()
                
                
            }
        }
    }
    
    func startOfMonth()  {
        
   /*   /*  let calendar = NSCalendar.currentCalendar()
        let date = NSDate()
       let components = calendar.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear , fromDate: date)
        var dateFormater = NSDateFormatter()
        
        dateFormater.timeZone = NSTimeZone()
        dateFormater.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormater.timeStyle = NSDateFormatterStyle.MediumStyle
        
//        dateFormater.stringFromDate(date)

      //  dateFormater.dateFromString(date)
     //   components.month
        
        // Getting the First and Last date of the month
        components.day = 1
        
       // components.year = 2015
     //   date.
        let firstDateOfMonth: NSDate = calendar.dateFromComponents(components)!
      //  return firstDateOfMonth
        
        //firstDateOfMonth.
    println("first \(dateFormater.stringFromDate(firstDateOfMonth))")
       // components.month  += 1
        components.day += 1
        components.day     = 0
        let lastDateOfMonth: NSDate = calendar.dateFromComponents(components)!
println(" last \(dateFormater.stringFromDate(lastDateOfMonth))")
        //return calendar.dateByAddingComponents(months, toDate: self, options: nil)*/
        var calendar = NSCalendar.currentCalendar()
        var date = NSDate()
        var components = calendar.components(.CalendarUnitDay | .CalendarUnitMonth | .CalendarUnitYear , fromDate: date)
         var dateFormater = NSDateFormatter()
        dateFormater.timeZone = NSTimeZone()
        dateFormater.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormater.timeStyle = NSDateFormatterStyle.MediumStyle
        var  begining = calendar.dateFromComponents(components)!
        println("first \(calendar.dateFromComponents(components)!)")
        
         components = NSDateComponents()
        components.day = 1
        date = NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: begining, options: .allZeros)!
        date = date.dateByAddingTimeInterval(-1)
        
        println("last \(date)")
        //return date*/
        
    }
    
    var canteen = [Canteen]()
    
    @IBOutlet weak var canteenItems: UIView!
    
    @IBOutlet weak var canteenPicker: UIPickerView!
    
    @IBOutlet weak var newItem: UITextField!
    
    @IBOutlet weak var quantity: UITextField!
    
    
    @IBOutlet weak var availableQ: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBAction func addNewItem(sender: AnyObject) {
        var itemToBeAdded = foodBill()
        itemToBeAdded.code = canteen[itemChosen].code
        itemToBeAdded.item = canteen[itemChosen].item
        itemToBeAdded.quantity = NSNumber(int: (quantity.text as NSString).intValue)
        itemToBeAdded.price = canteen[itemChosen].price
        itemToBeAdded.totalprice = itemToBeAdded.price.floatValue * itemToBeAdded.quantity.floatValue
        
        BoardManager.sharedInstance.board1.foodCharges.append(itemToBeAdded)
        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Member")
        var predicate: NSPredicate = NSPredicate(format: "code == %@", canteen[itemChosen].code)
        println("\(canteen[itemChosen].code)")
        
        fetchRequest.predicate =  predicate
        var error: NSError?
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as! [Canteen]?

        if let results = fetchedResults {
            //   members = results
            if (results.count != 0){
                var managedObject = results[0]
                println("Found")
                
              var new_quantity = results[0].quantity.integerValue + (itemToBeAdded.quantity).integerValue
                
                
                
                results[0].quantity = NSNumber(integer: new_quantity)
                
                managedContext.save(nil)
                
                
            } else {
                //memberDetailsDisplay.text = "Couldnt find Member!!!"
            }
        } else {
            
            println("Couldnt find")
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        tableView.reloadData()
    }
    
    
    @IBAction func addCanteenItem(sender: AnyObject) {
        
        canteenItems.hidden = false
        canteenPicker.hidden = true
        
       /* UIView.animateWithDuration(
            0.5,
            delay: 0.0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0.5,
            options: UIViewAnimationCurve.EaseInOut,
            animations: {, completion: nil
        )*/
        
    //    UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: <#() -> Void##() -> Void#>, completion: <#((Bool) -> Void)?##(Bool) -> Void#>)
        
        
        // UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: nil, completion: nil)
        

        
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        let managedContext = appDelegate.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Canteen")
        var error: NSError?
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as! [Canteen]?
        
        
        if let results = fetchedResults {
            canteen = results
            println("loading")
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        println("Reloading")
       canteenPicker.reloadAllComponents()
    }
    
    
    @IBAction func donewithCanteen(sender: AnyObject) {
        
        foodCost.text = "\(BoardManager.sharedInstance.board1.totalp)"
        BoardManager.sharedInstance.board1.foodCost = BoardManager.sharedInstance.board1.totalp
        println("Fodd cost \(BoardManager.sharedInstance.board1.foodCost)")
        canteenItems.hidden = true
        
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        println("count \(BoardManager.sharedInstance.board1.foodCharges.count + 1)")
        return BoardManager.sharedInstance.board1.foodCharges.count + 1
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        if (indexPath.row ==  BoardManager.sharedInstance.board1.foodCharges.count) {
            
            var cell = self.tableView.dequeueReusableCellWithIdentifier(
                "totalCellBill", forIndexPath: indexPath) as! totalCellBill
            cell.totalprice.text = "\(BoardManager.sharedInstance.board1.totalp)"
            cell.totalquantity.text = "\(BoardManager.sharedInstance.board1.totalq)"
            return cell
            
            
        }  else  {
            
           // println("index \(indexPath.row) \(food[indexPath.row])")
            var cell = self.tableView.dequeueReusableCellWithIdentifier(
                "itemCellBill", forIndexPath: indexPath) as! itemCellBill
            
            cell.item.text = BoardManager.sharedInstance.board1.foodCharges[indexPath.row].item
            cell.price.text = "\(BoardManager.sharedInstance.board1.foodCharges[indexPath.row].price)"
            cell.quantity.text = "\(BoardManager.sharedInstance.board1.foodCharges[indexPath.row].quantity)"
            cell.totalPrice.text = "\(BoardManager.sharedInstance.board1.foodCharges[indexPath.row].totalprice)"
            
            if indexPath.row == 0 {
                BoardManager.sharedInstance.board1.totalp = 0
                BoardManager.sharedInstance.board1.totalq = 0
            }
            BoardManager.sharedInstance.board1.totalq += (BoardManager.sharedInstance.board1.foodCharges[indexPath.row ].quantity).integerValue
            BoardManager.sharedInstance.board1.totalp += (BoardManager.sharedInstance.board1.foodCharges[indexPath.row ].totalprice).floatValue
            println("P : \(BoardManager.sharedInstance.board1.totalp) Q: \(BoardManager.sharedInstance.board1.totalq)")
            return cell
            
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if ( indexPath.row ==  canteen.count ) {
            return false
        } else {
            return true
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if (editingStyle == UITableViewCellEditingStyle.Delete ) {
            //add code here for when you hit delete
            
            BoardManager.sharedInstance.board1.foodCharges.removeAtIndex(indexPath.row)
            self.tableView!.beginUpdates()
        
            
            self.tableView!.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
            
            
            
            self.tableView!.reloadData()
            self.tableView!.endUpdates()
            
            
            
            println("Deleted")
        }
        
        
    }

    func calculateTime () {
        let date = NSDate()
        
        // First moment of a given date
       // let startOfDay = NSCalendar.currentCalendar().startOfDayForDate(date)
        
        // Components to calculate end of day
        
        // Last moment of a given date
        var flags : NSCalendarUnit = NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear
        let components = NSCalendar.currentCalendar().components(flags, fromDate: date)
       //components.month = 1
        components.day = 1
        
        var   startOfDay = NSCalendar.currentCalendar().startOfDayForDate(date)
        
        var endofMonth = NSCalendar.currentCalendar().dateByAddingUnit( NSCalendarUnit.CalendarUnitMonth, value: 1, toDate: startOfDay, options: NSCalendarOptions())
           // dateBySettingUnit(NSCalendarUnit.CalendarUnitDay, value: 1, ofDate: startOfDay, options: NSCalendarOptions())
        
        
        var endOfDay = NSCalendar.currentCalendar().dateFromComponents(components)
        
        //(NSCalendarUnit.CalendarUnitDay, value: 1, ofDate: endofMonth!, options: NSCalendarOptions())
        
        
        println("start date \(startOfDay) end date \(endOfDay) end of Month \(endofMonth)")
        
            
        
        
        }
        
        
        
    
    

}
