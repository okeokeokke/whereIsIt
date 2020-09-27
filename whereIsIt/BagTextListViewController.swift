//
//  BagTextListViewController.swift
//  whereIsIt
//
//  Created by 桶本あいか on 2020/08/29.
//  Copyright © 2020 Okemoto.Okke. All rights reserved.
//

import UIKit
import RealmSwift

class BagTextListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let realm = try! Realm()
    var textNameArrays: Results<Book>!
    @IBOutlet var table: UITableView!
    @IBOutlet var toolbar: UIToolbar!
    var selectedText: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        textNameArrays = realm.objects(Book.self)
        textNameArrays = textNameArrays.filter("status == 'bagTextListView'")
        table.allowsMultipleSelectionDuringEditing = true //セルの複数選択を可能にする
        navigationItem.rightBarButtonItem = editButtonItem //右上に編集ボタンを追加
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        print(textNameArrays)
        table.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
       super.setEditing(editing, animated: animated)
       table.isEditing = editing
       toolbar.isHidden = false
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textNameArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        textNameArrays = textNameArrays.filter("status == 'bagTextListView'")
        print("検索後,tableView", self.textNameArrays)
        cell?.textLabel?.text = "\(textNameArrays[indexPath.row].textSubjectName)" + " " +  "\(textNameArrays[indexPath.row].textName)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print("tableViewは平気")
        if table.isEditing == isEditing {
            //        print("if動いている")
            
            selectedText.append(indexPath.row)
        }
        // 選択した行番号が出力される
//        print("選択された番号",indexPath.row)
//        print("実際に選択された値",textNameArrays[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // 選択解除した行番号が出力される
        print(indexPath.row)
        if let firstIndex = selectedText.index(of: indexPath.row) {
            print("インデックス番号: \(firstIndex)")
            selectedText.remove(at: firstIndex)
            print("削除後",selectedText)
        }
        
    }
    
    @IBAction func toLocker() {
        print(selectedText,"chosen")
        print(selectedText.count)
        for i in 0..<selectedText.count {
            let text = textNameArrays[selectedText[i]]
            try! self.realm.write {
                text.status = "rockerTextListView"
                self.realm.add(text)
                print("b")
            }
        }
        print("selectedTextの配列の中身",selectedText)
        print("a")
        print(textNameArrays)
        table.reloadData()
        selectedText = []
    }
    
    @IBAction func toHome() {
        print(selectedText,"chosen")
        print(selectedText.count)
        for i in 0..<selectedText.count {
            let text = textNameArrays[selectedText[i]]
            print(text,"選択されたもの")
            try! self.realm.write {
                text.status = "homeTextListView"
                self.realm.add(text)
            }
        }
        print("selectedTextの配列の中身",selectedText)
        print(textNameArrays)
        table.reloadData()
        selectedText = []
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
