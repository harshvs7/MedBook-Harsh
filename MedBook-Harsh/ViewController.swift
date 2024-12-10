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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            //Check to see if user is logged in or not
            if let loggedIn = AppDefaults.shared.loggedIn, loggedIn {
                let vc = HomeViewController()
                vc.delegate = self
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let vc = LoginViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        })
        
    }
}

extension ViewController: HomeVCProtocol {
    func openLoginViewController() {
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
