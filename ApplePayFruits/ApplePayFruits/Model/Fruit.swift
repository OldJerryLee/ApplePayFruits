//
//  Fruit.swift
//  ApplePayFruits
//
//  Created by Fabricio Pujol on 09/07/20.
//  Copyright © 2020 Fabricio Pujol. All rights reserved.
//

import UIKit

struct Fruit {
    let image: UIImage?
    let title: String
    let price: NSDecimalNumber
    let description: String

    init(image: UIImage?, title: String, price: NSDecimalNumber, description: String) {
        self.image = image
        self.title = title
        self.price = price
        self.description = description
    }

    var priceString: String {
        let dollarFormatter: NumberFormatter = NumberFormatter()
        dollarFormatter.minimumFractionDigits = 2;
        dollarFormatter.maximumFractionDigits = 2;
        return dollarFormatter.string(from: price)!
    }
}
