//
//  WelcomeViewController.swift
//  FitnessPoints
//
//  Created by Paul Dickey on 12/7/18.
//  Copyright © 2018 Paul Dickey. All rights reserved.
//

import UIKit
import Firebase


class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //If there is a logged in user, by pass this screen and go straight to ChatViewController
        navigationController?.setNavigationBarHidden(false, animated: false)
        //let workoutViewController = storyboard?.instantiateViewController(withIdentifier: "workoutViewController") as! WorkoutViewController

//        if Auth.auth().currentUser != nil {
//            present(workoutViewController, animated: true, completion: nil)
//        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
