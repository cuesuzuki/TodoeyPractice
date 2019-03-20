//
//  ViewController.swift
//  Todory
//
//  Created by yutaka suzuki on 2019/03/15.
//  Copyright © 2019 yutaka suzuki. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    // Itemの配列をつくる - ハードコーティングされた３つのアイテム
    var itemArray = [Item]()
    
    //UserDefaultsを使用するには、新しいオブジェクトを作成する必要がある
    //deaultsを呼ぶとデフォルトのデータベースと同じユーザーデフォルトに設定される
    //standardを設定する。新しいアイテムをリストに追加する部分に行けるようになる
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //★コードを記述する位置が大事！(defaultsキーのobject内容を削除する)
        //defaults.removeObject(forKey: "TodoListArray")

        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Buy Eggs"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demagorgon"
        itemArray.append(newItem3)
        

        if let items = defaults.array(forKey: "TodoListArray") as? [Item]{
            itemArray = items

        }
        
    }

    // MARK - TableView Datasouece Methods
      // サブクラス化
    // セクション行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    // セルの中身
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]

        cell.textLabel?.text = item.title
        
        //turnary operator ==>
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

        tableView.reloadData()
        
        // ↑　テーブル選択行のindexPathをアニメーション化(点滅)してかわいくする
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //MARK - Add New Items
    
    //①アラート表示させるためのバーボタンを追加
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        // リストに項目を書き込んだあとに追加できるように警告するアラート
        
//UITextField()を変数化することで、アクションボタン内で表示するタイミング（ブロック）の問題を解決できる
        var textField = UITextField()
        
        //②アクションとテキストフィールドを持つアラートを作成
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
            //クロージャーの内側にあるときはオブジェクトにはselfを追加する
            // ④これを書かないと更新（表示）されない！
            self.tableView.reloadData()
            
        }
        //③アラート内のアイテム追加ボタンをクリックするとtextFieldに書いたものをitemArrayに[追加]。
        alert.addTextField { (alertTextField) in
            //アイテムボタンを押すと何が起きるかわかるアラート
            alertTextField.placeholder = "Create new item"
            //入力されたテキストをどうやってつかんでprintへ渡すのか？
            textField = alertTextField
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}

