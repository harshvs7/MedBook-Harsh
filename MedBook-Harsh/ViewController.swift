//
//  ViewController.swift
//  MedBook-Harsh
//
//  Created by Harshvardhan Sharma on 19/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check to see if user is logged in or not
        if let loggedIn = AppDefaults.shared.loggedIn, loggedIn {
            let vc = HomeViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = LoginViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    
}

