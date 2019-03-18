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
    var itemArray = ["Find Mike","Buy Eggs", "Destroy Demogorgon"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK - TableView Datasouece Mesods
      // サブクラス化
    // セクション行数
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // 配列の数だけセルの行をつくる
        return itemArray.count
    }
    
    // セルの中身
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // indexPathの識別子を持つ再生可能なセルを作成する
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        // textLabelを正しく設定する
        // 単一セルにあるラベル、.textプロパティを利用して、アイテム配列のアイテムと同じになるように設定する
        cell.textLabel?.text = itemArray[indexPath.row]
        
        // このメソッドは最後に再利用セルで作成されたセルを返す
        return cell
        
        // 現在の行のテキストが入力され、TableViewに戻され、業として表示される
        
    }
    
    // セクション数
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //MARK - TableView Delegate Methods
    // タップすると（indexPathの行番号を表示）するデリゲートメソッド
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        //print(itemArray[indexPath.row])
        // 配列の添字番号でなく項目名を出力したい
        
        //白に戻るので今度はアクセサリーでチェックマークをつける
        //デフォルトにならないようコードで書く
        
        //もしセル行にチェックマークがついていたら、アクセサリをnoneに変更したい
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{ tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
            
        }
        
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
            //このタイミングでprintなどを表示したい
            //でも、やりたいのはprintでなく、itemArrayに[追加]すること！
            self.itemArray.append(textField.text!)
            
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

