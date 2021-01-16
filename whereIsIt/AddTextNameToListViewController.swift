//
//  AddTextNameToListViewController.swift
//  whereIsIt
//
//  Created by 桶本あいか on 2020/09/05.
//  Copyright © 2020 Okemoto.Okke. All rights reserved.
//

import UIKit
import RealmSwift

class AddTextNameToListViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    //    var textNameArray = [String]()
    var textNameArrays: Results<Book>!
    var selectedItem: Subject!
   
    
    let realm = try!Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = selectedItem.name
        table.dataSource = self
        textNameArrays = realm.objects(Book.self)
        textNameArrays = textNameArrays.filter("textSubjectName == '\(selectedItem.name)'")
        textNameArrays = textNameArrays.sorted(byKeyPath: "statusNumber", ascending: true)
//        print("検索後,viewDidRoad", self.textNameArrays)
        table.register(UINib(nibName: "AddTextNameTableViewCell", bundle: nil),forCellReuseIdentifier:"addTextNameTableViewCell")
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
//        let item = UIBarButtonItem(customView: view)
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        table.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textNameArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addTextNameTableViewCell") as! AddTextNameTableViewCell
//        cell.subjectLabel.text = String(textNameArrays[indexPath.row].textSubjectName)
        cell.textNameLabel.text = String(textNameArrays[indexPath.row].textName)
        if textNameArrays[indexPath.row].status == "homeTextListView" {
            cell.tagImage.image = UIImage(named: "houseStatus.png")
        } else if textNameArrays[indexPath.row].status == "rockerTextListView" {
            cell.tagImage.image = UIImage(named: "lockerStatus.png")
        } else if textNameArrays[indexPath.row].status == "bagTextListView" {
            cell.tagImage.image = UIImage(named: "bagStatus.png")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let text = textNameArrays[indexPath.row]
            do {
                let realm = try Realm()
                try! realm.write {
                    realm.delete(text)
//                    print(textNameArrays)
                }
            } catch {
            }
            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    @IBAction func onPlusButtonTapped(_ sender: Any) {
        var uiTextField = UITextField()
        let book = Book()
        print("\(selectedItem)が受け渡された")
        let ac = UIAlertController(title: "教材名を入力してください", message: "", preferredStyle: .alert)
        let aa = UIAlertAction(title: "OK", style: .default) { (action) in
            //               self.textNameArray.append(uiTextField.text!)
            book.textSubjectName = self.selectedItem.name
            book.textName = uiTextField.text!
            book.status = "homeTextListView"
            
            try! self.realm.write {
                self.realm.add(book)
            }
            self.textNameArrays = self.textNameArrays.filter("textSubjectName == '\(self.selectedItem.name)'")
//            print(self.textNameArrays)
//            print("検索後,afterPlus", self.textNameArrays)
            
            //            print(uiTextField.text!)
            self.table.reloadData()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
//            print(uiTextField.text!)
        }
        ac.addTextField { (textField) in
            textField.placeholder = "教材名"
            uiTextField = textField
        }
        ac.addAction(cancel)
        ac.addAction(aa)
        present(ac, animated: true, completion: nil)
        
        //        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        //               // アクションを実装
        //            print("\(indexPath.row)番目の行が選択されました。")
        //           }
        
    }
    
    func filter() {
        //データベース内に保存してあるPersonモデルを全て取得します。
        var results = realm.objects(Book.self)
        
        //この時のresults内の要素の配列は不定です。
//        print("検索前", results)
        //BookのtextSubjectName == selectedItemのname
        results = results.filter("textSubjectName == '\(selectedItem.name)'")
//        print("検索後", results)
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
