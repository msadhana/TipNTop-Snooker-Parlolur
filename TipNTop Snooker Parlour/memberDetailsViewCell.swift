//
//  memberDetailsViewCell.swift
//  TipNTop Snooker Parlour
//
//  Created by Dineshkumar on 15/05/15.
//  Copyright (c) 2015 TipNTop Cue Sports. All rights reserved.
//

import UIKit

class memberDetailsViewCell: UITableViewCell {

    @IBOutlet weak var membername: UILabel!
    
    
    @IBOutlet weak var contact: UILabel!
    
    @IBOutlet weak var memberid: UILabel!
    
    @IBOutlet weak var Balance: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

class titleCell: UITableViewCell {
    
    
}

class itemCell: UITableViewCell {
    
    @IBOutlet weak var codeNo: UITextField!
    @IBOutlet weak var item: UITextField!
    
    @IBOutlet weak var quantity: UITextField!
    
    @IBOutlet weak var price: UITextField!
    
     @IBOutlet weak var totalPrice: UITextField!
    
}

class itemCellBill: UITableViewCell {
    
    @IBOutlet weak var item: UITextField!
    
    @IBOutlet weak var quantity: UITextField!
    
    @IBOutlet weak var price: UITextField!
    
    @IBOutlet weak var totalPrice: UITextField!
    
}
class totalCell: UITableViewCell{
    
    @IBOutlet weak var totalquantity: UITextField!
    
    @IBOutlet weak var totalprice: UITextField!
    
}

class totalCellBill: UITableViewCell{
    
    @IBOutlet weak var totalquantity: UITextField!
    
    @IBOutlet weak var totalprice: UITextField!
    
}

