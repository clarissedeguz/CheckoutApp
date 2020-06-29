//
//  ViewController.swift
//  POS App
//
//  Created by Claire De Guzman on 2020-06-28.
//  Copyright © 2020 Claire De Guzman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var overallEnt: UILabel!
    @IBOutlet weak var amountEnt: UILabel!
    @IBOutlet weak var enter: UIButton!
    var receipt: [String] = []
    var runningNumber = ""
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func taxLogic() -> String {
           let overallAmount = Double(overallEnt.text!)
           var tax: Double? = 0
           var taxDisplayed: String?
        
        tax = (overallAmount ?? 0) * 0.13
        taxDisplayed = String(format: "%.2f", tax ?? "0")
           return taxDisplayed ?? "0"
           
       }
    
    func discountLogic() -> String {
        let overallAmount = Double(overallEnt.text ?? "0")
        var discount: Double = 0
        var discountDisplayed: String
        
        if overallAmount ?? 0.00 >= 500.00 {
            discount = (overallAmount ?? 0) * 0.50
        } else {
            discount = (overallAmount ?? 0) * 0.20
        }
        
        discountDisplayed = String(format: "%.2f", discount)
        return discountDisplayed
        
    }
    
    
    @IBAction func numbers(_ sender: UIButton) {
        let taxToDisplay = taxLogic()
        let discountToDisplay = discountLogic()
        
        switch sender.tag {
        case 11: runningNumber = "10"
        case 12: runningNumber = "8"
        case 13: runningNumber = "15"
        case 14: runningNumber = "20"
        case 15: runningNumber = "\(taxToDisplay)"
        case 16: runningNumber =  "\(discountToDisplay)"
        default: runningNumber += "\(sender.tag - 1)"
        }
        amountEnt.text = runningNumber
        
    }
    
    @IBAction func allClear(_ sender: UIButton) {
        runningNumber = ""
        amountEnt.text = runningNumber
        overallEnt.text = runningNumber
    }
    
    
    @IBAction func enterPressed(_ sender: UIButton)  {
        let overallResults = logic()
        overallEnt.text = overallResults
        runningNumber = ""
        amountEnt.text = runningNumber
    }
    
    func logic() -> String{
        
        let amountEntered = Double(amountEnt.text!) ?? 0
        let overallEntered = Double(overallEnt.text!) ?? 0
        var answer: Double = 0
        var results = ""
        let discount = discountLogic()
        let tax = taxLogic()
        
        answer = amountEntered + overallEntered
       
        switch amountEnt.text {
        case "10" : receipt.append("Meat: $10")
        case "8" :  receipt.append("Vegetable: $8")
        case "15" : receipt.append("Dairy: $15")
        case "20" :  receipt.append("Alcohol: $20")
        case "\(discount)":
            let discountNumber = Double(discount)
            answer = overallEntered - discountNumber!
            
            if answer >= 500 {
                receipt.append("50% Discount $500+ : $\(discount)")
            } else {
                receipt.append("20% Discount under $500 : $\(discount)")
            }
            
        case "\(tax)" :
            let taxNumber = Double(tax)
            answer = overallEntered + taxNumber!
            receipt.append("Tax 13%: $\(tax)")
            
        default: receipt.append("Item: $\(amountEnt.text!)")
        }
        
        results = (NSString(format: "%.2f", answer) as String)
        return results
        
        
    }
    
    @IBAction func receiptPressed(_ sender: UIButton) {
    
        let okalert = UIAlertController(title: "Receipt Total: $\(overallEnt.text!)", message: receipt.joined(separator: "\n"),preferredStyle: UIAlertController.Style.alert)
               
        let ok = UIAlertAction(title: "Okay!", style: UIAlertAction.Style.default, handler: { (ACTION) in okalert.dismiss(animated: true, completion: nil)})

               print("YES")

               okalert.addAction(ok)
               self.present(okalert, animated: true, completion: nil)
        
        receipt.removeAll()

    }
        

     
        
    }
        
        
        
    
        

        
        
        
        
        
        
        
        
    
    
        

   
    
    
    
    
    
    
    
    


