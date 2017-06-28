//
//  InventoryViewController.swift
//  MidTermClicker
//
//  Created by Harry Li on 2017-06-27.
//  Copyright © 2017 Harry. All rights reserved.
//

import UIKit

class InventoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, InventoryVCDelegate {

//    protocol InventoryVCDelegate {
//        func showNextVC()
//    }
    
    @IBOutlet weak var inventoryTableView: UITableView!
    
    var player:Player?
    let outputFormatter: OutPutFormatter?
    var delegate<InventoryVCDelegate>?
    
    
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
        
        var currentItem = player?.inventory[indexPath.row]
        
        
        itemCell.itemImageView.image = currentItem?.iconImage
        itemCell.itemDescriptionTextView.text = outputFormatter?.itemDetailsFormatter(item: currentItem)
        
        return itemCell
    }
    
   

}
