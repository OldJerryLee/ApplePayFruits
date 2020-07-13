//
//  BuyFruitViewController.swift
//  ApplePayFruits
//
//  Created by Fabricio Pujol on 09/07/20.
//  Copyright © 2020 Fabricio Pujol. All rights reserved.
//

import UIKit
import PassKit

class BuyFruitViewController: UIViewController {

    @IBOutlet weak var fruitPriceLabel: UILabel!
    @IBOutlet weak var fruitTitleLabel: UILabel!
    @IBOutlet weak var fruitImage: UIImageView!
    @IBOutlet weak var buyButton: UIButton! {
        didSet{
            buyButton.layer.cornerRadius = buyButton.frame.height/2
        }
    }

    var fruit: Fruit! {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {

        if (!self.isViewLoaded) {
            return
        }

        self.title = fruit.title
        self.fruitPriceLabel.text = "$" + fruit.priceString
        self.fruitImage.image = fruit.image
        self.fruitTitleLabel.text = fruit.title
        fruitImage.layer.cornerRadius = fruitImage.frame.height/2

        buyButton.layer.cornerRadius = 7
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    @IBAction func purchase(sender: UIButton) {
        
        //1
        let paymentItem = PKPaymentSummaryItem.init(label: fruit.title, amount: fruit.price)
        
        //2
        let paymentMethods: [PKPaymentNetwork] = [PKPaymentNetwork.amex, .visa, .masterCard, .elo]
        
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentMethods) {
            
            let request = PKPaymentRequest()
            request.currencyCode = "USD" // 1
            request.countryCode = "US" // 2
            request.merchantIdentifier = "merchant.com.appFruitsTest.ApplePayFruits" // 3
            request.merchantCapabilities = .capability3DS // 4
            request.supportedNetworks = paymentMethods // 5
            request.paymentSummaryItems = [paymentItem] // 6
            
            guard let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: request) else {
                print("Failed opening authorization view controller")
                return
            }
            paymentVC.delegate = self
            self.present(paymentVC, animated: true, completion: nil)
        }
        else {
            print("nao consegue fazer pagamentos")
        }
    }
    
}

extension BuyFruitViewController: PKPaymentAuthorizationViewControllerDelegate {

    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
        
        completion(.success)
    }
    
}
