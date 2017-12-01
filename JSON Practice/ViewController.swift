//
//  ViewController.swift
//  JSON Practice
//
//  Created by Kelly Douglass on 11/30/17.
//  Copyright © 2017 Kelly Douglass. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
	@IBOutlet weak var table: UITableView!
	var productsArr : JSON?
	
	
	let url = "https://metaderm.herokuapp.com/products"
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if productsArr != nil {
			return productsArr!.count
		} else {
			return 1
		}
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
		
		if let productsReturned = productsArr {
			cell.textLabel?.text = String(describing: productsReturned[indexPath.row]["productName"])
		}
		return cell
		
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		Alamofire.request(url).responseJSON{
			response in
			if response.result.isSuccess {
				print("Success")
				let data : JSON = JSON(response.result.value!)
				
				self.productsArr = data
				self.table.reloadData()
			} else {
				print("Error")
			}
		}
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	override func viewDidAppear(_ animated: Bool) {
		table.reloadData()
	}

}

