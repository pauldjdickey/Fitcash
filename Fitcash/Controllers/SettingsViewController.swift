//
//  SettingsViewController.swift
//  FitnessPoints
//
//  Created by Paul Dickey on 12/10/18.
//  Copyright © 2018 Paul Dickey. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation


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
            //let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            // let welcomeViewController = storyBoard.instantiateViewController(withIdentifier: "welcomeViewController") as! WelcomeViewController
            //let navigationController = UINavigationController(rootViewController: welcomeViewController)
            //present(welcomeViewController, animated: false, completion: nil)
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let navigationController = storyBoard.instantiateViewController(withIdentifier: "mainNavigationController") as! UINavigationController
            present(navigationController, animated: false, completion: nil)
            
        } catch {
            print("error: there was a problem logging out")
        }
    }
    
}
