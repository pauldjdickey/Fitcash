//
//  RedeemCompanyViewController.swift
//  Fitcash
//
//  Created by Paul Dickey on 12/23/18.
//  Copyright © 2018 Paul Dickey. All rights reserved.
//

import UIKit
import Firebase

class RedeemCompanyViewController: UITableViewController {

    var offercategories = [OfferCompany]()
    let pointsDB = Database.database().reference().child("Users")
    var nameOfCategory = ""
    let spinner = UIActivityIndicatorView(style: .gray)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.setNavigationBarHidden(false, animated: false)
        fetchCompanyOffers()
        print(nameOfCategory)
    }
    //
    override func viewWillAppear(_ animated: Bool) {
        //navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.navigationBar.topItem?.hidesBackButton = false
        navigationItem.title = "\(nameOfCategory)"
        //fetchOffers()
    }
    //
    func fetchCompanyOffers() {
        Database.database().reference().child("Offer_Category").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                // Need to fix this so the "Food and drink" child is unique based on what we tapped to segue
                self.tableView.backgroundView = self.spinner
                self.spinner.startAnimating()
                Database.database().reference().child("Offer_Category").child(self.nameOfCategory).child("Offer_Company").observe(.childAdded) { (offercategorysnapshot) in
                    // Need to make this safe...
                    if let dictionary = offercategorysnapshot.value as? [String: AnyObject] {
                        self.spinner.stopAnimating()
                        let offerCategory = OfferCompany()
                        offerCategory.offerCompanyName = dictionary["offerCompanyName"] as? String
                        self.offercategories.append(offerCategory)
                        self.tableView.reloadData()
                    }
                }
            } else {
                print("No categories available")
                self.spinner.stopAnimating()
            }
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return offercategories.count
        
    }
    
    //This is what will go into the cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "redeemCompanyOfferCell", for: indexPath)
        
        let offer = offercategories[indexPath.row]
        cell.textLabel?.text = offer.offerCompanyName
        //        if offer.cost != nil {
        //            cell.detailTextLabel?.text = ("Tap to redeem for \(offer.cost!) points.")
        //        } else {
        //            cell.detailTextLabel?.text = "Tap to redeem"
        //        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToRedeemOffer", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToRedeemOffer" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destinationController = segue.destination as! RedeemOfferViewController
                let offerCompany = offercategories[indexPath.row]
                destinationController.nameOfCategory = nameOfCategory
                destinationController.nameOfCompany = offerCompany.offerCompanyName!
            }
        }
    }
}
