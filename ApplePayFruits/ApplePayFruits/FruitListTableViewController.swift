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
        Fruit(   image: UIImage(named: "fruit01"),
                title: "Cherry",
                price: 54.00,
                description: "This book is for beginner to advanced iOS developers. Whether you are a complete beginner to making iOS games, or an advanced iOS developer looking to learn about Sprite Kit, you will learn a lot from this book!"),

        Fruit(   image: UIImage(named: "fruit02"),
        title: "Orange",
        price: 54.00,
        description: "This book is for beginner to advanced iOS developers. Whether you are a complete beginner to making iOS games, or an advanced iOS developer looking to learn about Sprite Kit, you will learn a lot from this book!"),

        Fruit(   image: UIImage(named: "fruit03"),
        title: "Banana",
        price: 54.00,
        description: "This book is for beginner to advanced iOS developers. Whether you are a complete beginner to making iOS games, or an advanced iOS developer looking to learn about Sprite Kit, you will learn a lot from this book!"),

        Fruit(   image: UIImage(named: "fruit04"),
        title: "Apple",
        price: 54.00,
        description: "This book is for beginner to advanced iOS developers. Whether you are a complete beginner to making iOS games, or an advanced iOS developer looking to learn about Sprite Kit, you will learn a lot from this book!"),

        Fruit(   image: UIImage(named: "fruit05"),
        title: "Strawberry",
        price: 54.00,
        description: "This book is for beginner to advanced iOS developers. Whether you are a complete beginner to making iOS games, or an advanced iOS developer looking to learn about Sprite Kit, you will learn a lot from this book!"),

        Fruit(   image: UIImage(named: "fruit06"),
        title: "Grape",
        price: 54.00,
        description: "This book is for beginner to advanced iOS developers. Whether you are a complete beginner to making iOS games, or an advanced iOS developer looking to learn about Sprite Kit, you will learn a lot from this book!"),
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
