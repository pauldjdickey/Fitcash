//
//  RedeemOfferViewController.swift
//  Fitcash
//
//  Created by Paul Dickey on 12/23/18.
//  Copyright © 2018 Paul Dickey. All rights reserved.
//

import UIKit
import Firebase

class RedeemOfferViewController: UITableViewController {
    
    var offers = [Offer]()
    let pointsDB = Database.database().reference().child("Users")
    var nameOfCategory = ""
    var nameOfCompany = ""
    let spinner = UIActivityIndicatorView(style: .gray)

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.setNavigationBarHidden(false, animated: false)
        fetchCompanyOffers()
        print(nameOfCategory)
        print(nameOfCompany)
    }
    //
    override func viewWillAppear(_ animated: Bool) {
        //navigationController?.setNavigationBarHidden(true, animated: true)
        navigationController?.navigationBar.topItem?.hidesBackButton = false
        navigationItem.title = "\(nameOfCompany)"
        //fetchOffers()
    }
    //
    func fetchCompanyOffers() {
        self.tableView.backgroundView = self.spinner
        self.spinner.startAnimating()
        Database.database().reference().child("Offer_Category").observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                // Need to fix this so the "Food and drink" child is unique based on what we tapped to segue
                
                Database.database().reference().child("Offer_Category").child(self.nameOfCategory).child("Offer_Company").child(self.nameOfCompany).child("Offers").observe(.childAdded) { (offercategorysnapshot) in
                    // Need to make this safe...
                    if let dictionary = offercategorysnapshot.value as? [String: AnyObject] {
                        self.spinner.stopAnimating()
                        let offerCategory = Offer()
                        offerCategory.cost = dictionary["cost"] as? Int
                        offerCategory.title = dictionary["title"] as? String
                        offerCategory.code = dictionary["code"] as? String
                        self.offers.append(offerCategory)
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
        return offers.count
        
    }
    
    //This is what will go into the cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "redeemOfferCell", for: indexPath)
        
        let offer = offers[indexPath.row]
        cell.textLabel?.text = offer.title
                if offer.cost != nil {
                    cell.detailTextLabel?.text = ("Tap to redeem for \(offer.cost!) points.")
                } else {
                    cell.detailTextLabel?.text = "Tap to redeem"
                }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let offer = offers[indexPath.row]
        
        let redeemAlert = UIAlertController(title: "Redeem", message: "Are you sure you'd like to redeem '\(offer.title!)' for \(offer.cost!) points?", preferredStyle: UIAlertController.Style.alert)
        redeemAlert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: { action in
            print("Time to redeem!")
            self.pointsDB.child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.exists() {
                    self.pointsDB.child(Auth.auth().currentUser!.uid).child("points").observeSingleEvent(of: .value, with: { (snapshot) in
                        let snapshotValue = snapshot.value as! Int
                        let points = snapshotValue
                        if points >= offer.cost! {
                            let EnoughToRedeemAlert = UIAlertController(title: "Congratulations!", message: "You have used \(offer.cost!) points to redeem this coupon! Check out your wallet to use it in store.", preferredStyle: UIAlertController.Style.alert)
                            EnoughToRedeemAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                            self.present(EnoughToRedeemAlert, animated: true, completion: nil)
                            let updatedPointsWithRedeem = points - offer.cost!
                            let pointsUpdatedWithRedeem = ["points": updatedPointsWithRedeem]
                            self.pointsDB.child(Auth.auth().currentUser!.uid).setValue(pointsUpdatedWithRedeem) {
                                (error, reference) in
                                
                                if error != nil {
                                    print(error!)
                                } else {
                                    print("Points saved successfully and offer added to wallet!")
                                    //THIS IS WHERE WE NEED TO SAVE THE OFFER TO OUR FIREBASE WALLET
                                    //Right now this is replacing our points value, for some reason, how do we fix that?
                                    let currentOffer = offer.title
                                    let currentOfferCode = offer.code
                                    let autoIDRef = Database.database().reference().child("Redeemed").child(Auth.auth().currentUser!.uid).childByAutoId()
                                    let autoIDRefString = autoIDRef.key
                                    let offers2 = ["title": currentOffer, "uuid": autoIDRefString, "code": currentOfferCode]
                                    
                                    autoIDRef.updateChildValues(offers2 as [AnyHashable : Any])
                                    
                                    //                                    self.pointsDB.child(Auth.auth().currentUser!.uid).child("offers").observeSingleEvent(of: .value, with: { (snapshotcheck) in
                                    //                                        if snapshotcheck.exists() {
                                    //                                            print("The snapshot for offers exists!")
                                    //                                            //This is where we will create the offers tab and append the first items
                                    //                                        } else {
                                    //                                            //This saves the title to a snapshot called offers, even if there isn't an offer there. We need to next it though and continue to add to it...
                                    //                                            //This is where we will add childs to the offers tab, each child needs the title and date of expiration
                                    //                                            let currentOffer = offer.title
                                    //                                            let offers2 = ["title": currentOffer]
                                    //                                            //self.pointsDB.child(Auth.auth().currentUser!.uid).child("RedeemedOffers").child(offer.title!).updateChildValues(offers2 as [AnyHashable : Any])
                                    //                                            self.pointsDB.child(Auth.auth().currentUser!.uid).child("redeemedoffers").child(offer.title!).updateChildValues(offers2 as [AnyHashable : Any])
                                    //                                            //Database.database().reference().child("Users/\(Auth.auth().currentUser!.uid)/\()").child(offer.title!).setValue(offers2 as [AnyHashable : Any])
                                    //                                            //Database.database().reference().child("Users/\(Auth.auth().currentUser!.uid)/RedeemedOffers").childByAutoId().updateChildValues(offers2 as [AnyHashable : Any])
                                    //
                                    //                                        }
                                    //                                    })
                                    
                                    
                                    
                                }
                            }
                        } else {
                            let notEnoughToRedeemAlert = UIAlertController(title: "Sorry", message: "You don't have enough points for this offer. Complete more workouts to get more points!", preferredStyle: UIAlertController.Style.alert)
                            notEnoughToRedeemAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                            self.present(notEnoughToRedeemAlert, animated: true, completion: nil)
                        }
                    })
                } else {
                    print("No user data to load")
                    let noPointsToRedeemAlert = UIAlertController(title: "Sorry", message: "You don't have any points. Complete a workout to get your first points.", preferredStyle: UIAlertController.Style.alert)
                    noPointsToRedeemAlert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil))
                    self.present(noPointsToRedeemAlert, animated: true, completion: nil)
                }
            })
            
        }))
        redeemAlert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.destructive, handler: { action in
            print("Okay, cancel selection")
        }))
        self.present(redeemAlert, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
