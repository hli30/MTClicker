//
//  InventoryViewController.swift
//  MidTermClicker
//
//  Created by Harry Li on 2017-06-27.
//  Copyright © 2017 Harry. All rights reserved.
//

import UIKit

class InventoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var inventoryTableView: UITableView!
    
    var player:Player!
    let outputFormatter = OutPutFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Table View
    
    public func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return player.inventory.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let itemCell:ItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell
        
        let currentItem = player.inventory[indexPath.row]
        
        guard let image = UIImage.convertDataToImage(dataToBeConverted: currentItem.iconImage) else {
            return itemCell
            
        }
        
        itemCell.itemImageView.image = image
        itemCell.itemDescriptionTextView.text = outputFormatter.itemDetailsFormatter(item: currentItem)
        
        
        return itemCell
    }
    
   

}
