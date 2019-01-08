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


class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
   
    
    
    let defaults = UserDefaults.standard
    @IBOutlet weak var favoriteGymPickerView: UIPickerView!
    
    var pickerData: [String] = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.navigationItem.leftBarButtonItem = nil
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.setHidesBackButton(true, animated: false)
        
        self.favoriteGymPickerView.delegate = self
        self.favoriteGymPickerView.dataSource = self
        
        pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.navigationItem.title = "Settings"

    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("\(pickerData[row])")
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
