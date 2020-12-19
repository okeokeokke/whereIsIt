//
//  TextNameListViewController.swift
//  whereIsIt
//
//  Created by 桶本あいか on 2020/12/19.
//  Copyright © 2020 Okemoto.Okke. All rights reserved.
//
//
//  TextNameListViewController.swift
//  whereIsIt
//
//  Created by 桶本あいか on 2020/12/19.
//  Copyright © 2020 Okemoto.Okke. All rights reserved.
//
import UIKit
import RealmSwift

class TextNameListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let realm = try! Realm()
    var textNameArrays: Results<Book>!
    var subjectArray: Results<Subject>!
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        textNameArrays = realm.objects(Book.self)
        textNameArrays = textNameArrays.sorted(byKeyPath: "statusNumber", ascending: true)
        textNameArrays = textNameArrays.sorted(byKeyPath: "textSubjectName", ascending: true)
        
        table.register(UINib(nibName: "TextTableViewCell", bundle: nil),forCellReuseIdentifier:"customTableViewCell")
//        table.rowHeight = 40
        subjectArray = realm.objects(Subject.self)

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
        var subjectColorArray = realm.objects(Subject.self)
        cell.subjectLabel.text = String(textNameArrays[indexPath.row].textSubjectName)
        cell.textNameLabel.text = String(textNameArrays[indexPath.row].textName)
        subjectColorArray = subjectColorArray.filter("name == '"  + textNameArrays[indexPath.row].textSubjectName+"'")
        print(subjectColorArray)
        cell.subjectColor.image = UIImage(data: subjectColorArray[0].colorImage as! Data)
        if textNameArrays[indexPath.row].status == "homeTextListView" {
            cell.tagImage.image = UIImage(named: "houseStatus.png")
        } else if textNameArrays[indexPath.row].status == "rockerTextListView" {
            cell.tagImage.image = UIImage(named: "lockerStatus.png")
        } else if textNameArrays[indexPath.row].status == "bagTextListView" {
            cell.tagImage.image = UIImage(named: "bagStatus.png")
        }
        return cell
    }
    
    @IBAction func sortByStatus() {
        textNameArrays = textNameArrays.sorted(byKeyPath: "textSubjectName", ascending: true)
        textNameArrays = textNameArrays.sorted(byKeyPath: "statusNumber", ascending: true)
        table.reloadData()
    }
    
    @IBAction func sortBySubject() {
        textNameArrays = textNameArrays.sorted(byKeyPath: "statusNumber", ascending: true)
        textNameArrays = textNameArrays.sorted(byKeyPath: "textSubjectName", ascending: true)
        table.reloadData()
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



    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



