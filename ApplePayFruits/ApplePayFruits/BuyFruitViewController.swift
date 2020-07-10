//
//  BuyFruitViewController.swift
//  ApplePayFruits
//
//  Created by Fabricio Pujol on 09/07/20.
//  Copyright © 2020 Fabricio Pujol. All rights reserved.
//

import UIKit

class BuyFruitViewController: UIViewController {

    @IBOutlet weak var swagPriceLabel: UILabel!
    @IBOutlet weak var swagTitleLabel: UILabel!
    @IBOutlet weak var swagImage: UIImageView!
    @IBOutlet weak var applePayButton: UIButton!

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
        self.swagPriceLabel.text = "$" + fruit.priceString
        self.swagImage.image = fruit.image
        self.swagTitleLabel.text = fruit.title
        swagImage.layer.cornerRadius = swagImage.frame.height/2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()
    }

    @IBAction func purchase(sender: UIButton) {
        // TODO: - Fill in implementation
    }

}
