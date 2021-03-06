//
//  HomeTextListViewController.swift
//  whereIsIt
//
//  Created by 桶本あいか on 2020/08/29.
//  Copyright © 2020 Okemoto.Okke. All rights reserved.
//

import UIKit
import RealmSwift

class HomeTextListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
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
        //        print("検索前,homeViewDidRoad", self.textNameArrays)
        textNameArrays = textNameArrays.filter("status == 'homeTextListView'")
        textNameArrays = textNameArrays.sorted(byKeyPath: "textSubjectName", ascending: true)
        table.register(UINib(nibName: "ListViewTextTableViewCell", bundle: nil),forCellReuseIdentifier:"listViewTextCustomCell")
        //        print("検索後,homeViewDidRoad", self.textNameArrays)
        //        print("ViewDidLoadが実行")
        table.allowsMultipleSelectionDuringEditing = true //セルの複数選択を可能にする
        navigationItem.rightBarButtonItem = editButtonItem //右上に編集ボタンを追加
//        navigationItem.rightBarButtonItem?.title = "編集"
        self.editButtonItem.title = "編集"
//        table.rowHeight = 40
        toolbar.isHidden = true
        
        //        textNameArrays = textNameArrays.filter("status == 'homeTextListView'")
        //        print("検索後,homeViewDidRoad", self.textNameArrays)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        table.isEditing = false
//        toolbar.isHidden = true
//        navigationItem.rightBarButtonItem?.title = "編集"
        table.reloadData()
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if(self.isEditing){
            table.isEditing = true
            toolbar.isHidden = false
            self.editButtonItem.title = "完了"
//            navigationItem.rightBarButtonItem?.title = "完了"
        }else{
            table.isEditing = false
            toolbar.isHidden = true
            self.editButtonItem.title = "編集"
//            navigationItem.rightBarButtonItem?.title = "編集"
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textNameArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listViewTextCustomCell") as! ListViewTextTableViewCell
        var subjectColorArray = realm.objects(Subject.self)
        textNameArrays = textNameArrays.filter("status == 'homeTextListView'")
        cell.subjectLabel.text = String(textNameArrays[indexPath.row].textSubjectName)
        cell.textNameLabel.text = String(textNameArrays[indexPath.row].textName)
        subjectColorArray = subjectColorArray.filter("name == '"  + textNameArrays[indexPath.row].textSubjectName+"'")
        cell.subjectColor.image = UIImage(data: subjectColorArray[0].colorImage as! Data)
        //        print("検索後,tableView", self.textNameArrays)
//        cell?.textLabel?.text = "\(textNameArrays[indexPath.row].textSubjectName)" + " " +  "\(textNameArrays[indexPath.row].textName)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        print("tableViewは平気")
        if table.isEditing == isEditing {
            
            //        print("if動いている")
            selectedText.append(indexPath.row)
        }
        // 選択した行番号が出力される
        //       print("選択された番号",indexPath.row)
        //        print("実際に選択された値",textNameArrays[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        // 選択解除した行番号が出力される
        print(indexPath.row)
        if let firstIndex = selectedText.index(of: indexPath.row) {
//            print("インデックス番号: \(firstIndex)")
            selectedText.remove(at: firstIndex)
//            print("削除後",selectedText)
        }
    }
    
    @IBAction func toLocker() {
        var texts:[Book] = []
//        print(selectedText,"chosen")
//        print(textNameArrays,"TOの直前")
//        print(selectedText.count)
        for i in 0..<selectedText.count {
            texts.append((textNameArrays[selectedText[i]]))
        }
        try! self.realm.write {
            for i in 0..<selectedText.count {
                texts[i].status = "rockerTextListView"
                texts[i].statusNumber = 1
            }
            self.realm.add(texts)
        }
        
        
//        print("selectedTextの配列の中身",selectedText)
//        print("a")
//        print(textNameArrays)
        table.reloadData()
        selectedText = []
        texts = []
    }
    
    @IBAction func toBag() {
        var texts:[Book] = []
//        print(selectedText,"chosen")
//        print(textNameArrays,"TOの直前")
//        print(selectedText.count)
        for i in 0..<selectedText.count {
            texts.append((textNameArrays[selectedText[i]]))
        }
        try! self.realm.write {
            for i in 0..<selectedText.count {
                texts[i].status = "bagTextListView"
                texts[i].statusNumber = 2
            }
            self.realm.add(texts)
        }
        
//        print("selectedTextの配列の中身",selectedText)
//        print(textNameArrays)
        table.reloadData()
        selectedText = []
        texts = []
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
