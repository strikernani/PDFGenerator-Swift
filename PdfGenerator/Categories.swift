//
//  Categories.swift
//  Logity
//
//  Created by Mahender Reddy on 27/06/17.
//  Copyright © 2017 Mahender Reddy. All rights reserved.
//

import UIKit
import Foundation


let screenSize: CGRect = UIScreen.main.bounds
let screenWidth = screenSize.width
let screenHeight = screenSize.height


//TODO:- Navigation Method
func navigateTo(_ contrlerName : String, navigationCtrl : UINavigationController)  {
    
    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let vcToNav = mainStoryboard.instantiateViewController(withIdentifier: contrlerName)
    navigationCtrl.pushViewController(vcToNav, animated: true)
}


func showAlert(alertMessage : String, viewController : UIViewController) -> Void
{
    let alertController = UIAlertController(title: "Mahender's Dev site", message:
        alertMessage, preferredStyle: UIAlertControllerStyle.alert)
    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
    viewController.present(alertController, animated: true, completion: nil)
    
}




