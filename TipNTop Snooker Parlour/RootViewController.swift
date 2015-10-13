//
//  RootViewController.swift
//  TipNTop Snooker Parlour
//
//  Created by Dineshkumar on 11/05/15.
//  Copyright (c) 2015 TipNTop Cue Sports. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import MessageUI

public var loggedin = false

class RootViewController: UIViewController, MFMailComposeViewControllerDelegate, UITextFieldDelegate{
    
    
    @IBAction func logOut(sender: AnyObject) {
        self.view.hidden = true
        loggedin = false
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        // self.tableView.rowHeight = UITableViewAutomaticDimension
        println("Appear \(loggedin)")
        if (loggedin == false) {
            self.view.hidden = true
            var alert = UIAlertController(title: "Root User",
                message: "Enter password",
                preferredStyle: .Alert)
            
            let LoginAction = UIAlertAction(title: "Login",
                style: .Default) { (action: UIAlertAction!) -> Void in
                    
                    let textField = alert.textFields![0] as! UITextField
                    if(textField.text == BoardManager.sharedInstance.password) {
                        self.view.hidden = false
                        loggedin = true
                    } else {
                        self.view.hidden = true
                        self.popupAlert("Wrong Password!!!")
                        loggedin = false
                        
                    }
                    
            }
            
            let cancelAction = UIAlertAction(title: "Cancel",
                style: .Default) { (action: UIAlertAction!) -> Void in
                    self.view.hidden = true
                    loggedin = false
            }
            
            alert.addTextFieldWithConfigurationHandler {
                (textField: UITextField!) -> Void in
            }
            
            alert.addAction(LoginAction)
            alert.addAction(cancelAction)
            
            presentViewController(alert,
                animated: true,
                completion: nil)
        } else {
            self.view.hidden = false
        }
        
    }
    
    @IBAction func generatePDF(sender: AnyObject) {
        self.generatePDF()
    }
    
    @IBAction func sendEmail(sender: AnyObject) {
        
        configuredMailComposedViewController()
    }
    
    @IBOutlet weak var oldPassword: UITextField!

    
    @IBOutlet weak var newPassword: UITextField!
    
    @IBOutlet weak var confirmPassword: UITextField!
    
    
    @IBAction func passwordChange(sender: AnyObject) {
        
        var alert1 = UIAlertController(title: "",
            message: " ",
            preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Ok",
            style: .Default) { (action: UIAlertAction!) -> Void in
                alert1.dismissViewControllerAnimated(true, completion: nil)
        }
        
        
        alert1.addAction(cancelAction)
        
        if oldPassword.text == BoardManager.sharedInstance.password {
            
            if newPassword.text == confirmPassword.text {
                BoardManager.sharedInstance.password  = newPassword.text

                alert1.title = "Password Changed"
                presentViewController(alert1,
                    animated: true,
                    completion: nil)

                
            } else {
                alert1.title = "Passwords do not match"
                presentViewController(alert1,
                    animated: true,
                    completion: nil)
            }
            
        } else {
            
            alert1.title = "Incorrect existng password"
            presentViewController(alert1,
                animated: true,
                completion: nil)
            
        }
        
        
    }
    func generatePDF() {
        var fileName = "sample.pdf"
        var path: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        var documentDirectory : NSString = path.objectAtIndex(0) as! NSString
        var pdfPathWithFileName = documentDirectory.stringByAppendingPathComponent(fileName)
        
        println("path \(pdfPathWithFileName)")
        
        UIGraphicsBeginPDFContextToFile(pdfPathWithFileName, CGRectZero, nil)
        UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 1100, 1100), nil)
        
        var context:CGContextRef = UIGraphicsGetCurrentContext()
        var rect: CGRect = CGRectMake(0, 0, pageSize.width, pageSize.height)
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        
        CGContextFillRect(context, rect)
        
        
        self.draw()
        UIGraphicsEndPDFContext()
        
        
    }
    
    
    func drawStr() {
        var context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
        
        var rectText = CGRectMake(0,0,1100,1100)
        
        var strtoprint : NSString = createstr()
        println("strings \n \(strtoprint)")
        var textstyl = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textstyl.alignment = NSTextAlignment.Right
        
        var attri = [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSBackgroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "Avenir", size: 20)!,
            NSParagraphStyleAttributeName: textstyl
        ]
        
        strtoprint.drawInRect(rectText, withAttributes: attri)
        
    }
    
    func draw() {
        var cont = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(cont, UIColor.blackColor().CGColor)
        
        var rectDraw = CGRectMake(0, 0, 1100, 1100)
        var str : NSString = createstr()
        println("sting \n \(str)")
        var textSt = NSMutableParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        textSt.alignment = NSTextAlignment.Justified
        
        var attrib = [
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSBackgroundColorAttributeName: UIColor.whiteColor(),
            NSFontAttributeName: UIFont(name: "Avenir", size: 20)!,
            NSParagraphStyleAttributeName: textSt
        ]
        
        str.drawInRect(rectDraw, withAttributes: attrib)
    }
    var subjectstring : NSString = ""
    var newString : NSString = ""
    var people = [Person]()
    func createstr() -> NSString {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        
        //self.navigationItem.leftBarButtonItem = self.editButtonItem;
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let fetchRequest = NSFetchRequest(entityName:"Person")
        var error: NSError?
        
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
        subjectstring = ""
        var withstr = " "
        subjectstring = "Date          Name                Cost\n========================================\n"
        var dateFormater = NSDateFormatter()
        dateFormater.dateFormat = "dd-MM-yyyy"
        for Person in people {
            //subjectstring += "\(Person.time)     \(Person.name )     \(Person.cost)"
            newString = "\(dateFormater.stringFromDate(Person.time))     \(Person.name.stringByPaddingToLength(20, withString: withstr, startingAtIndex: 0))\(Person.cost)\n"
            subjectstring.stringByAppendingString(newString as String)
            subjectstring = "\(subjectstring) \(newString)"
            println("string is a: \(subjectstring)  b: \(newString)")
            
        }
        
        return subjectstring
        
    }
    
    

    func drawText() {
        
        var context:CGContextRef = UIGraphicsGetCurrentContext()
        // CGContextSetFillColorWithColor(context, UIColor.orangeColor().CGColor)
        
        var textRect: CGRect = CGRectMake(0, 0, 1100, 1100)
        createstr()
        //  var text : NSString = subjectstring
        var text : NSString = "Sadhana"
        
        let font = UIFont(name: "Helvetica Bold", size: 20.0)
        
        //let textRect: NSRect = NSMakeRect(5, 3, 125, 18)
        
        
        let textColor =  UIColor.blackColor()
        
        // if let actualFont = font {
        
        var attributes = [
            NSBackgroundColorAttributeName: UIColor.whiteColor(),
            NSForegroundColorAttributeName: UIColor.blackColor(),
            NSFontAttributeName: UIFont(name: "Avenir", size: 30)!
        ]
        
        //pdfOutput.text.drawInRect(textRect,withAttributes: attributes)
        
        // }
        var abc = ""
        
        
        text.drawInRect(textRect, withAttributes: nil)
        
        
    }
    var pageSize : CGSize = CGSizeMake(1100, 1100)
    
    
    
    func createPDF() {
        
        var testView =  UIView.alloc()
        //var pdfDate :NSMutableData = NSMutableData()
        // UIGraphicsBeginPDFContextToData(pdfData, CGRectMake(0.0f, 0.0f, 792.0f, 612.0f ), nil)
        UIGraphicsBeginPDFPage()
        var pdfContext = UIGraphicsGetCurrentContext()
        // CGContextScaleCTM(pdfContext, 0.773f, 0.773f )
        
        testView.layer.renderInContext(pdfContext)
        UIGraphicsEndPDFContext()
        
        
        
        
    }
    
    
    func configuredMailComposedViewController()-> MFMailComposeViewController{
        
        var picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
        
        picker.setSubject("sadhana")
        var fileName = "sample.pdf"
        var path: NSArray = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        var documentDirectory : NSString = path.objectAtIndex(0) as! NSString
        var pdfPathWithFileName = documentDirectory.stringByAppendingPathComponent(fileName)
        var fileData : NSData? = NSData(contentsOfFile: pdfPathWithFileName)
        picker.addAttachmentData(fileData, mimeType: "application/pdf", fileName: pdfPathWithFileName)
        
        picker.setMessageBody("sadhana", isHTML: true)
        picker.setToRecipients(["sadhusterlings@gmail.com"])
        
        
        presentViewController(picker, animated: true, completion: nil)
        return picker
        
        
    }
    
            func popupAlert(alert: NSString) {
        var alert1 = UIAlertController(title: alert as String,
            message: " ",
            preferredStyle: .Alert)
        
        
        
        let cancelAction = UIAlertAction(title: "Ok",
            style: .Default) { (action: UIAlertAction!) -> Void in
                alert1.dismissViewControllerAnimated(true, completion: nil)
                
        }
        
        
        
        alert1.addAction(cancelAction)
        
        presentViewController(alert1,
            animated: true,
            completion: nil)
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!){
        /*  switch (result.value) {
        case MFMailComposeResultSent.value:
        //popupAlert("Mail sent!!")
        break;
        case MFMailComposeResultSaved.value:
        //popupAlert("Mail saved!!")
        break;
        case MFMailComposeResultCancelled.value:
        //popupAlert("Mail Cancelled!!")
        break;
        case MFMailComposeResultFailed.value:
        //popupAlert("Mail sending failed")
        break;
        default:
        // popupAlert("Error occured!! Please check your internet connection")
        break;
        }*/
        /*  if(result.value == MFMailComposeResultSent.value) {
        println("Mail sent")
        
        }*/
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}
