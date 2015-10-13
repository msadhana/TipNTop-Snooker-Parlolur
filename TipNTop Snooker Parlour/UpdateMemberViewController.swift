//
//  UpdateMemberViewController.swift
//  TipNTop Snooker Parlour
//
//  Created by Dineshkumar on 29/06/15.
//  Copyright (c) 2015 TipNTop Cue Sports. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public var memberid_value = 0


class UpdateMemberViewController : ViewController ,UITextFieldDelegate, UINavigationControllerDelegate{
    
    
    let managedContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
    
    var result_members = [Member]()
    
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var emailid: UITextField!
    
    
    
    @IBOutlet weak var phoneno: UITextField!
    
    @IBOutlet weak var initDeposit: UITextField!
    
  //  @IBOutlet weak var idTypetext: UITextField!
    
    @IBOutlet weak var balance: UITextField!
    
    @IBOutlet weak var topUp: UITextField!
    
  //  @IBOutlet weak var personalphoto: UIImageView!
    
 //   @IBOutlet weak var idProofPhoto: UIImageView!
    
 //   @IBOutlet weak var idPicker: UIPickerView!
    
    @IBOutlet weak var discountPicker: UIPickerView!
    
    @IBOutlet weak var memberId: UITextField!
    
    @IBOutlet weak var discount: UITextField!
    
 //   @IBOutlet weak var print: UIButton!
 //   @IBOutlet weak var cardview: UIImageView!
   
    var discountPercentage = 50
    
   // var imageTosave = 0
    
 //   var popover:UIPopoverController? = nil
  //  let picker = UIImagePickerController()
    
    
//    var imageToSave1 = UIImage()
//    var imageToSave2 = UIImage()
    
    
 //   @IBOutlet weak var id_proof_btn: UIButton!
 //   @IBOutlet weak var personal_photo_btn: UIButton!
  /*  var alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
    override func viewDidAppear(animated: Bool) {
        self.print.hidden = true
    }
@IBAction func chooseImage(sender: AnyObject){
        
        imageTosave = sender.tag
        
        println("image to save \(imageTosave)")
        
        var cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.openCamera()
                
        }
        var gallaryAction = UIAlertAction(title: "Gallary", style: UIAlertActionStyle.Default)
            {
                UIAlertAction in
                self.openGallary()
        }
        var cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel)
            {
                UIAlertAction in
                // alert.dismissViewControllerAnimated(true, completion: nil)
        }
        // Add the actions
        alert.addAction(cameraAction)
        alert.addAction(gallaryAction)
        alert.addAction(cancelAction)
        // Present the actionsheet
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone
        {
            
            self.presentViewController(alert, animated: true, completion: nil)
        }
        else
        {
            popover=UIPopoverController(contentViewController: alert)
            
            popover!.presentPopoverFromRect(sender.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
            openCamera()
            
            //  popover!.dismissPopoverAnimated(true)
        }
        
        //alert.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func openCamera()
    {
        
        
        
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera))
        {
            println("choosing camera")
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            
            
            self.presentViewController(picker, animated: true, completion: nil)
        }
        else
        {
            openGallary()
        }
    }
    func openGallary()
    {
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone
        {
            
            self.presentViewController(picker, animated: true, completion: nil)
        }
        else
        {
            popover = UIPopoverController(contentViewController: picker)
            
            if imageTosave == 0 {
                popover!.presentPopoverFromRect(personal_photo_btn.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
            } else {
                popover!.presentPopoverFromRect(id_proof_btn.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject])
    {
        
        println("didFinishPicking")
        if (imageTosave == 0) {
            personalphoto.contentMode = UIViewContentMode.ScaleAspectFit
            
            personalphoto.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            
            println("save photo at 0")
            imageToSave1 = info[UIImagePickerControllerOriginalImage] as! UIImage
        }
        else {
            
           // idProofPhoto.contentMode = UIViewContentMode.ScaleAspectFit
            //idProofPhoto.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            
            println("save photo at 1")
            imageToSave2 = info[UIImagePickerControllerOriginalImage] as! UIImage
            
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        popover!.dismissPopoverAnimated(true)
        alert.dismissViewControllerAnimated(true, completion: nil)
        
        
    }

   */
    @IBAction func topUp(sender: AnyObject) {
        println("result \(result_members[0].name)")
        if(topUp.text != "0") {
        var balance_amt = result_members[0].balance.integerValue + (topUp.text as NSString).integerValue
        
        if discountPercentage != 0 {
            balance_amt += ((topUp.text as NSString).integerValue * discountPercentage) / 100
        }
        result_members[0].balance = NSNumber(integer: balance_amt)
        
        managedContext.save(nil)
        balance.text = "\(result_members[0].balance.integerValue)"
        } else {
            println("Please enter amount")
            popupAlert("Please enter value to Top Up", self)
        }
        
    }
    
    @IBAction func updateDetails(sender: AnyObject) {
      //  var imageData =  UIImageJPEGRepresentation(imageToSave1,1)
        
        //var idproof = UIImageJPEGRepresentation(imageToSave2,1)
        
        
      //  result_members[0].setValue(imageData,forKey: "personalphoto")
      //  result_members[0].setValue(idproof,forKey: "idproof")
        result_members[0].setValue(emailid.text, forKey: "email")
        result_members[0].setValue(phoneno.text, forKey: "phoneno")
        var balance_value = NSNumber(int: ((balance.text as NSString).intValue))
        result_members[0].setValue(balance_value, forKey: "balance")
     //   result_members[0].setValue(idTypetext.text, forKey: "idtype")
        
        
        managedContext.save(nil)
        
        
    }
    
    /* let appDelegate =
    UIApplication.sharedApplication().delegate as AppDelegate*/
    
    
    override func viewDidLoad() {
        
        
        var members = [Member]()
       // idProofPhoto.contentMode = UIViewContentMode.ScaleAspectFit
      //  personalphoto.contentMode = UIViewContentMode.ScaleAspectFit
        
      //  idPicker.hidden = true
        discountPicker.hidden = true
        
        discount.delegate = self
        discount.inputView = discountPicker
        
      //  idTypetext.delegate = self
      //  idTypetext.inputView = idPicker
        
        
        discount.text = "\(discountPercentage) %"
        topUp.text = "0"
        
        let fetchRequest = NSFetchRequest(entityName:"Member")
        println(memberid_value)
        var predicate: NSPredicate = NSPredicate(format: "memberid == \(memberid_value)")
        fetchRequest.predicate =  predicate
        var error: NSError?
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as! [Member]?
        
        
        if  let results = fetchedResults {
            result_members = fetchedResults!
            if (results.count != 0){
                var managedObject = results[0]
                
                println("name: \(results[0].memberid)")
                
                var final_update = Int()
                
                name.text = results[0].name
                emailid.text = results[0].email
                balance.text = "\(results[0].balance)"
                memberId.text = "TNT\(results[0].memberid)"
                initDeposit.text = "\(results[0].deposit)"
                phoneno.text = "\(results[0].phoneno)"
                
                if (results[0].idtype != "") {
                    println("idType \(results[0].idtype)")
             //       idTypetext.text = "\(results[0].idtype)"
                }
               // idProofPhoto.image = UIImage(data: results[0].idproof)
               // personalphoto.image = UIImage(data: results[0].personalphoto)
                
            }
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
        
        
        
    }
    
   /* func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var count = Int(0)
        if pickerView.tag == 0 {
         count = idType.count
        } else  {
            count =  20
        }
        println("count :\(count)")
        return count
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if pickerView.tag == 0 {
            return  idType[row]  }
        else {
            return ("\(row  * 5)%")
            
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView.tag == 0 {
      //  idTypetext.text = idType[row]
        } else {
            discountPercentage = row  * 5
            discount.text = "\(row * 5) %"
        }
        //idPicker.hidden = true;
        discountPicker.hidden = true
        
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if textField.tag == 0 {
      //  cardview.hidden = true
       // self.print.hidden = true
            discountPicker.hidden = true
         //   idPicker.hidden = false }
        else if textField.tag == 1{
          //  cardview.hidden = true
           // self.print.hidden = true
          //  idPicker.hidden = true
            discountPicker.hidden = false
        }
        return false
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView!) -> UIView {
        let pickerLabel = UILabel()
        var titleData = ""
        var hue = CGFloat()
        
        if pickerView.tag == 0 {
        titleData = idType[row]
        hue = CGFloat(row)/CGFloat(idType.count)
        } else {
            titleData = "\(row * 5)%"
            hue = CGFloat(row)/CGFloat(20)
        }
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 26.0)!,NSForegroundColorAttributeName:UIColor.blackColor()])
        pickerLabel.attributedText = myTitle
        
                pickerLabel.backgroundColor = UIColor(hue: hue, saturation: 0.90, brightness:1.0, alpha: 0.5)
        pickerLabel.textAlignment = .Center
        return pickerLabel
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationViewController = segue.destinationViewController as! MemberLoginRecordsViewController
        
        destinationViewController.member_name = name.text
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        NSURLCache.sharedURLCache().removeAllCachedResponses()
        
    }
    */
  /*  @IBAction func generateCard(sender: AnyObject) {
        
        let textData = "\(memberid_value)".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter.setValue(textData, forKey: "inputMessage")
        filter.setValue("H", forKey: "inputCorrectionLevel") // error-correction level: H=30%, Q=25%, M=15% (default), L=7%
        var image = UIImage(CIImage: filter.outputImage)
        var headerimage = UIImage(named: "Header")
        
        
        
        
        
        UIGraphicsBeginImageContext(cardview.frame.size)
        
        
        headerimage?.drawInRect(CGRect(x: 25,y: 25,width: 250,height: 65))
        image?.drawInRect(CGRect(x: 320,y: 25,width: 150,height: 175))
        
        var rect = CGRectMake(cardview.frame.origin.x, cardview.frame.origin.y, image!.size.width, image!.size.height);
        
        var text = NSString(format: "Name: \(name.text)\n\nPhone Number: \(phoneno.text) ")
        var textColor: UIColor = UIColor.blackColor()
        var textFont: UIFont = UIFont(name: "CopperPlate", size: 20)!
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
        ]
        
        text.drawInRect(CGRect(x: 25,y: 95,width: 250,height: 300), withAttributes: textFontAttributes)
        
        var imageto = UIGraphicsGetImageFromCurrentImageContext()
        
        cardview.image = imageto
        UIGraphicsEndImageContext();
        self.cardview.hidden = false
        self.print.hidden = false
        
        
        
        
    }

    @IBAction func printCard(sender: AnyObject) {
        
        let printController = UIPrintInteractionController.sharedPrintController()!
        let printInfo = UIPrintInfo(dictionary:nil)!
        printInfo.outputType = UIPrintInfoOutputType.Photo
        printInfo.jobName = "print Job"
        printController.printInfo = printInfo
        
         printController.printingItem = cardview.image
        printController.presentFromRect(CGRect(origin: CGPoint(x: 0, y: 0), size: cardview.image!.size), inView: self.view, animated: true, completionHandler: nil)
        

        
    }*/
}
