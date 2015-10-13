import UIKit
//import MobileCoreServices
import CoreData

public var member_list = [Member]()
public var member_id_no = Int32(0001)

class MemberAddViewController: UIViewController , UINavigationControllerDelegate, UIPopoverControllerDelegate
{
    @IBOutlet weak var name: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var phoneno: UITextField!
    
    @IBOutlet weak var deposit: UITextField!
    
    override func viewDidLoad() {
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
    
       @IBAction func signUp(sender: AnyObject) {
        
        var deposit_value = NSNumber()

        var dep_no = UInt16((deposit.text as NSString).intValue)
        
        deposit_value = NSNumber(unsignedShort: dep_no)
       
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext! as NSManagedObjectContext
        
        let member = NSEntityDescription.insertNewObjectForEntityForName("Member", inManagedObjectContext: managedContext) as! Member
        
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
        member.setValue(name.text, forKey: "name")
        member.setValue(deposit_value, forKey: "deposit")
        
        member.setValue(email.text, forKey: "email")
        member.setValue(phoneno.text, forKey: "phoneno")
        member.setValue(deposit_value, forKey: "balance")
        member.setValue(NSNumber(int: member_id_no), forKey: "memberid")
        managedContext.save(nil)
        
        println(member.name)
        member_list.append(member)
        member_id_no++
        popupAlert("Member Saved!!")

        name.text = ""
        email.text = ""
        phoneno.text = ""
        deposit.text = ""
        
    }
    
    
    
    


}