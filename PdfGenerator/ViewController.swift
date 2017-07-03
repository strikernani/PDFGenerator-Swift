//
//  ViewController.swift
//  PdfGenerator
//
//  Created by Mahender Reddy on 30/06/17.
//  Copyright © 2017 Mahender Reddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var txtDescription: UITextField!
    @IBOutlet var txtPrice: UITextField!
    
    var items123: [[String: String]]!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if self.items123 == nil {
            self.items123 = [[String: String]]()
            
        }
        
        
        self.items123.append(["item": "MAHE_001", "price": "007"])
        
        if self.items123.count == 0
        {
            self.items123 = getItems()
        }
        
        self.navigationController?.isNavigationBarHidden = false
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func action_SavePriceDetails(_ sender: UIButton) {
        
        if txtDescription.text?.isEmpty == true
        {
           showAlert(alertMessage: "Please enter description", viewController: self)
        }
        else if txtPrice.text?.isEmpty == true
        {
            showAlert(alertMessage: "Please enter price", viewController: self)
        }else
        {
            self.items123.append(["item": txtDescription.text!, "price": txtPrice.text!])
            saveItems()
            
            txtPrice.text = ""
            txtDescription.text = ""
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    
    func saveItems()
    {
        UserDefaults.standard.set(self.items123, forKey: "saveditems")
        UserDefaults.standard.synchronize()
    }
    

}

extension UIViewController{
    
    func getItems() -> [[String: String]]!
    {
        return UserDefaults.standard.value(forKey: "saveditems") as! [[String : String]]!
    }

    
}

