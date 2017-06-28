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
    
    var player:Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: Table View
    
    public func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        let rows = player?.inventory.count
        return rows!
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let itemCell:ItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell
        
        itemCell.itemImageView.image = player?.inventory[indexPath.row].iconImage
        itemCell.itemDescriptionTextView.text = player?.inventory[indexPath.row].upgradeDescription
        
        return itemCell
    }
    
   

}
