//
//  BuyFruitViewController.swift
//  ApplePayFruits
//
//  Created by Fabricio Pujol on 09/07/20.
//  Copyright © 2020 Fabricio Pujol. All rights reserved.
//

import UIKit

class BuyFruitViewController: UIViewController {

    @IBOutlet weak var fruitPriceLabel: UILabel!
    @IBOutlet weak var fruitTitleLabel: UILabel!
    @IBOutlet weak var fruitImage: UIImageView!
    @IBOutlet weak var buyButton: UIButton!

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
        // TODO: - Fill in implementation
    }

}
