//
//  FruitListTableViewController.swift
//  ApplePayFruits
//
//  Created by Fabricio Pujol on 09/07/20.
//  Copyright © 2020 Fabricio Pujol. All rights reserved.
//

import UIKit

class FruitListTableViewController: UITableViewController {

    var fruitList = [
        Fruit(   image: UIImage(named: "fruit04"),
                title: "Cherry",
                price: 22.00,
                description: "Hi! I am a delicious Cherry, please buy me!!!"),

        Fruit(   image: UIImage(named: "fruit07"),
        title: "Orange",
        price: 120.00,
        description: "Hi! I am a delicious Orange, please buy me!!!"),

        Fruit(   image: UIImage(named: "fruit05"),
        title: "Banana",
        price: 74.00,
        description: "Hi! I am a delicious Banana, please buy me!!!"),

        Fruit(   image: UIImage(named: "fruit03"),
        title: "Apple",
        price: 54.00,
        description: "Hi! I am a delicious Apple, please buy me!!!"),

        Fruit(   image: UIImage(named: "fruit09"),
        title: "Strawberry",
        price: 14.00,
        description: "Hi! I am a delicious Strawberry, please buy me!!!"),

        Fruit(   image: UIImage(named: "fruit01"),
        title: "Grape",
        price: 38.00,
        description: "Hi! I am a delicious Grape, please buy me!!!"),
    ]

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = fruitList[indexPath.row]
                (segue.destination as! BuyFruitViewController).fruit = object
            }
        }
    }

    // MARK: - Table View
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruitList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FruitCell

        let object = fruitList[indexPath.row]
        cell.titleLabel.text = object.title
        cell.priceLabel.text = "$" + object.priceString
        cell.fruitImage.image = object.image
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

}
