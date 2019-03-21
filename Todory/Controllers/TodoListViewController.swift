//
//  ViewController.swift
//  Todory
//
//  Created by yutaka suzuki on 2019/03/15.
//  Copyright © 2019 yutaka suzuki. All rights reserved.

//sec 233:カスタムオブジェクトを保存する（UserDefault以外の方法）

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    // CoreDataのfilePathを作成し、グローバル定数にする
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
//    let defaults = UserDefaults.standard　のかわりに独自ファイルパスを作成
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)

/*  Optional(file:///Users/suzukiyutaka/Library/Developer/CoreSimulator/Devices/4FD55680-DD64-428E-84EA-5F31216B592A/data/Containers/Data/Application/EA8EDD7F-C73D-455D-8351-A9ED43FF2675/Documents/)
 */
        
        loadItems()
        

//        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
//            itemArray = items
//
//        }
        
    }

    // MARK - TableView Datasouece Methods
    // セクション行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // セルの中身
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]

        cell.textLabel?.text = item.title
        
        //"turnary operator" ==>
        //value = condition ? valueIfTrue : valueIfFalse
        
        cell.accessoryType = item.done ? .checkmark : .none

        return cell
        
    }
    
    // セクション数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK - TableView Delegate Methods
    // タップすると（indexPathの行番号を表示）するデリゲートメソッド
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add New Items
    
    //①アラート表示させるためのバーボタンを追加
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        //②アクションとテキストフィールドを持つアラートを作成
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            // UserDefault以外のアイテムはUserDefaultに保存しない！
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItems()
        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    //MARK - Model Manupulation Methods
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        } catch {
            print("Error encoding item array, \(error)")
        }
        
        // ④これを書かないと更新（表示）されない！
        self.tableView.reloadData()
        
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            }catch {
                print("Error decoding item array, \(error)")
            }
    }
    
}

}
