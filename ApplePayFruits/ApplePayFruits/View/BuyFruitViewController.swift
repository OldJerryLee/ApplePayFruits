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
            request.currencyCode = "BRL" // 1
            request.countryCode = "BR" // 2
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
        
        // 1: Define a chave de testes
        Stripe.setDefaultPublishableKey("pk_test_51H3NJ1KLN7LXpuRl312WQGRf1fhNyu3A3fKerUNzhmR6tiy18zHkLdK3g643flir1M77vKR1z854sMOfgGZIyO8C00q3jW0NlH")
        
        // 2: Cria o token do Stripe
        STPAPIClient.shared().createToken(with: payment) { (token, error) in
            
            // 3: Checamos se houve algum erro na criação do token
            if error != nil {
                print("\(String(describing: error?.localizedDescription))")
                completion(PKPaymentAuthorizationStatus.failure)
            }

            else {
                
                // 4: Definimos o endereço da URL
                let url = URL(string: "https://shoesstoretest.herokuapp.com/pay")
                
                var request = URLRequest(url: url!)
                request.httpMethod = "POST"
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                
                // 5: Adicionamos os atributos do JSON
                let body: [String: Any] = [
                    "stripeToken": token?.tokenId ?? "",
                    "amount": self.fruit.price.multiplying(by: 100),
                    "description": self.fruit.title
                ]
                
                request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions())
                
                let session = URLSession.shared

                let dataTask = session.dataTask(with: request) { (data, response, error) in
                    if error == nil {

                        print("PAYMENT SUCCEDED")
                        completion(PKPaymentAuthorizationStatus.success)

                    }
                    else {

                        print("PAYMENT FAILED")
                        completion(PKPaymentAuthorizationStatus.failure)

                    }
                }

                dataTask.resume()
                
            }
        }
    }
    
}
