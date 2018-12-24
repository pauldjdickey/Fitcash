//
//  SettingsViewController.swift
//  FitnessPoints
//
//  Created by Paul Dickey on 12/10/18.
//  Copyright © 2018 Paul Dickey. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.navigationItem.title = "Settings"

    }
    
    @IBAction func logOutPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: false)
        }
        catch {
            print("error: there was a problem logging out")
        }
    }
    
}
