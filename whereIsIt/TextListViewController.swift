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
        //subjectNameArrays = realm.objects(SubjectName.self)
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
        //textNameArray = []

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectNameArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = subjectNameArrays[indexPath.row].name
        return cell!
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
            print(self.subjectNameArrays)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("\(subjectNameArrays[indexPath.row])を選択")
        selectedItem = subjectNameArrays[indexPath.row]
        print("\(selectedItem)が受け渡される")
        
    
           // アクションを実装
       }
    
    func performSegueToBookList() {
        performSegue(withIdentifier: "toBookListView", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBookListView" {
            let bookViewController = segue.destination as! AddTextNameToListViewController
            bookViewController.selectedItem = self.selectedItem
        }
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
