//
//  PokemonTableViewController.swift
//  PokemonTable
//
//  Created by 洪德晟 on 2016/9/23.
//  Copyright © 2016年 洪德晟. All rights reserved.
//

import UIKit

class PokemonTableViewController: UITableViewController {

    var names = ["Blubasaur", "Ivysaur", "Venusar", "Charmander", "Charmeleon", "Charizard", "Squirtle", "Wartortle", "Blastoise"]
    
    var maxCP = ["1071", "1632", "2580", "955", "1557", "2602", "1008", "1582", "2542"]
    
    var images = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
    
    // 紀錄是否有這隻寶可夢
    var pokemonGot = [Bool](repeating: false, count: 9)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 更改標題
        self.title = "Pokemon Pokdex"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        // 增加Edit按鈕
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - TableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return names.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as! PokemonTableViewCell

        // Configure the cell...
        
        cell.pokemonImage.image = UIImage(named: images[indexPath.row])
        cell.pokemonName.text = names[indexPath.row]
        cell.pokemonMaxCP.text = maxCP[indexPath.row]
        cell.accessoryType = pokemonGot[indexPath.row] ? .detailButton : .detailDisclosureButton
        
        return cell
    }
    
    // MARK: - TableViewDelegate
    
//    // 選取row，新增提示控制器
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//    }
    
    
    // 選取按鈕，新增提示控制器
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        
        // 建立動作選單清單
        let optionMenu = UIAlertController(title: "邁向寶可夢大師之路", message: "你有這隻寶可夢嗎？", preferredStyle: .alert)
        
        // 將動作加入選單
        let cancelAction = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        // 為控制器加入動作 - 1. Call
        let callActionHandler = { (action: UIAlertAction!) -> Void in
            let alertmessage = UIAlertController(title: "大木博士不在家", message: "有事請留言", preferredStyle: .alert)
            alertmessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertmessage, animated: true, completion: nil)
            
        }
        
        let callAction = UIAlertAction(title: "打電話給大木博士", style: .default, handler: callActionHandler)
        optionMenu.addAction(callAction)
        
        // 為控制器加入動作 - 2. Get or not
        let hadGotTitle = (pokemonGot[indexPath.row]) ? "哎啊，這隻沒了" : "科科...我有這隻"
        let hadGotAction = UIAlertAction(title: hadGotTitle, style: .default,
        handler: {
            (action:UIAlertAction!) -> Void in
            
            let cell = tableView.cellForRow(at: indexPath)
            self.pokemonGot[indexPath.row] =
                (self.pokemonGot[indexPath.row]) ? false : true
            cell?.accessoryType =
                (self.pokemonGot[indexPath.row]) ? .detailButton : .detailDisclosureButton
        })
        optionMenu.addAction(hadGotAction)
        
        // 呈現選單
        self.present(optionMenu, animated: true, completion: nil)
        
        // 取消列的選取
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    // 自訂按鈕(share & delete)
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // Share Button (社群分享)
        let shareAction = UITableViewRowAction(style: UITableViewRowActionStyle.default, title: "Share", handler: { (action, indexPath) -> Void in
            
            let defaultText = "看看如此精美的" + self.names[indexPath.row] + "O.o!"
            
            if let imageToShare = UIImage(named: self.images[indexPath.row]) {
                
                let activityController = UIActivityViewController(activityItems: [defaultText, imageToShare], applicationActivities: nil)
                
                self.present(activityController, animated:true, completion: nil)
            }
            
        })
        
        // Delete Button (刪除)
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) -> Void in
            
            self.names.remove(at: indexPath.row)
            self.images.remove(at: indexPath.row)
            self.maxCP.remove(at: indexPath.row)
            self.pokemonGot.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            })
        
        
        // Set the button color (課製按鈕顏色)
        shareAction.backgroundColor = UIColor(red: 28.0/255.0, green: 165.0/255.0, blue: 253.0/255.0, alpha: 1.0)
        deleteAction.backgroundColor = UIColor(red: 202.0/255.0, green: 202.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        
        // 回傳按鈕
        return [deleteAction, shareAction]
    }
    
    // 預設的刪除按鈕(刪除表格列)
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // 從row中刪除
            names.remove(at: indexPath.row)
            maxCP.remove(at: indexPath.row)
            images.remove(at: indexPath.row)
            pokemonGot.remove(at: indexPath.row)
            
            // 更新row資料
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        } else if editingStyle == .insert {
            
        }
    }
    
    
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    
    // Override to support rearranging the table view.
    // 紀錄更改完的位置
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    

    
    // Override to support conditional rearranging of the table view.
    // 哪些可更改列的位置
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "openDetail" {
            
            // Get the destination view controller
            let destinationViewController = segue.destination as! DetailViewController
            
            // Get user selected index path
            let userSelectedIndexPath = self.tableView.indexPathForSelectedRow!
            
            // Get images & names
            let pokemonImage = UIImage(named: images[userSelectedIndexPath.row])
            let pokemonName = names[userSelectedIndexPath.row]
            
            // Put  into next ViewController property
            destinationViewController.pokemoninImage = pokemonImage
            destinationViewController.pokemonName = pokemonName
        }
        
    }
    

}
