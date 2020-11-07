//
//  TextNameListViewController.swift
//  whereIsIt
//
//  Created by 桶本あいか on 2020/10/04.
//  Copyright © 2020 Okemoto.Okke. All rights reserved.
//

import UIKit
import RealmSwift

class TextNameListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let realm = try! Realm()
    var textNameArrays: Results<Book>!
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        textNameArrays = realm.objects(Book.self)
        textNameArrays = textNameArrays.sorted(byKeyPath: "textSubjectName", ascending: true)
        table.register(UINib(nibName: "TextTableViewCell", bundle: nil),forCellReuseIdentifier:"customTableViewCell")
        table.rowHeight = 50

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        print("新たに家画面",textNameArrays)
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textNameArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCell") as! TextTableViewCell
        cell.subjectLabel.text = String(textNameArrays[indexPath.row].textSubjectName)
        cell.textNameLabel.text = String(textNameArrays[indexPath.row].textName)
        //        print("検索後,tableView", self.textNameArrays)
//        cell?.textLabel?.text = "\(textNameArrays[indexPath.row].textSubjectName)" + " " +  "\(textNameArrays[indexPath.row].textName)"
        return cell
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
