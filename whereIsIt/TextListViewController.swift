//
//  TextListViewController.swift
//  whereIsIt
//
//  Created by 桶本あいか on 2020/08/29.
//  Copyright © 2020 Okemoto.Okke. All rights reserved.
//

import UIKit
import RealmSwift

class TextListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var table: UITableView!
//    var subjectNameArray = [String]()
    var subjectNameArrays: Results<Subject>!
    
    let realm = try!Realm()
    var selectedItem: Subject!

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        subjectNameArrays = realm.objects(Subject.self)
        table.delegate = self
        table.register(UINib(nibName: "SubjectCustomTableViewCell", bundle: nil),forCellReuseIdentifier:"subjectCustomTableViewCell")
        //subjectNameArrays = realm.objects(SubjectName.self)
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
        //textNameArray = []

        // Do any additional setup after loading the view.
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }
    
    override func viewWillAppear(_ animated: Bool) {

        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectNameArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectCustomTableViewCell")as!SubjectCustomTableViewCell
        cell.subjectLabel.text = subjectNameArrays[indexPath.row].name
        print(type(of: subjectNameArrays[indexPath.row].colorImage))
        cell.subjectColorImage.image = UIImage(data: subjectNameArrays[indexPath.row].colorImage as! Data)
        return cell
    }
    
    @IBAction func onPlusButtonTapped(_ sender: Any) {
        var uiTextField = UITextField()
        let ac = UIAlertController(title: "教科名を入力してください", message: "", preferredStyle: .alert)
        let aa = UIAlertAction(title: "OK", style: .default) { (action) in
//            self.subjectNameArray.append(uiTextField.text!)
            let subject = Subject()
            subject.name = uiTextField.text!
            
            try! self.realm.write {
                self.realm.add(subject)
            }
//            print(self.subjectNameArrays)
            self.table.reloadData()
//            print(self.subjectNameArray)
//            print(uiTextField.text!)
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print(uiTextField.text!)
        }
        ac.addTextField { (textField) in
            textField.placeholder = "教科名"
            uiTextField = textField
        }
        ac.addAction(cancel)
        ac.addAction(aa)
        present(ac, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
//        print("\(subjectNameArrays[indexPath.row])を選択")
        selectedItem = subjectNameArrays[indexPath.row]
//        print("\(selectedItem)が受け渡される")
           // アクションを実装
       }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let alert: UIAlertController = UIAlertController(title: "注意", message: "教科名を削除するとその教科の教材も消えます", preferredStyle: .alert)
        let canselAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
                     print("キャンセル")
                 }
        let okAction: UIAlertAction = UIAlertAction(title: "削除", style: .default) { (action) in
                     // 「削除」が押された時の処理をここに記述
            if editingStyle == UITableViewCell.EditingStyle.delete {
                let subject = self.subjectNameArrays[indexPath.row]
                var results  = self.realm.objects(Book.self)
                results = results.filter("textSubjectName =  '\(subject.name)'")
                do {
                    let realm = try Realm()
                    try! realm.write {
                        realm.delete(results)
                        realm.delete(subject)
                        print(self.subjectNameArrays)
                    }
                } catch {
                }
                tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
            }
                     
        }
        alert.addAction(okAction)
        alert.addAction(canselAction)
        present(alert, animated: true, completion: nil)
//        if editingStyle == UITableViewCell.EditingStyle.delete {
//            let subject = subjectNameArrays[indexPath.row]
//            var results  = realm.objects(Book.self)
//            results = results.filter("textSubjectName =  '\(subject.name)'")
//            do {
//                let realm = try Realm()
//                try! realm.write {
//                    realm.delete(results)
//                    realm.delete(subject)
//                    print(subjectNameArrays)
//                }
//            } catch {
//            }
//            tableView.deleteRows(at: [indexPath as IndexPath], with: UITableView.RowAnimation.automatic)
//        }
    }
    
    
    
    func performSegueToBookList() {
        performSegue(withIdentifier: "toBookListView", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBookListView" {
            var bookViewController = segue.destination as! AddTextNameToListViewController
            //            print("\(selectedItem)を受け渡す準備完了")
            bookViewController.selectedItem = self.selectedItem
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toBookListView", sender: nil)
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
