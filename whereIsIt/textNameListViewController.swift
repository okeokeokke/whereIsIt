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
        textNameArrays = textNameArrays.sorted(byKeyPath: "textSubjectName", ascending: true)
        table.register(UINib(nibName: "TextTableViewCell", bundle: nil),forCellReuseIdentifier:"customTableViewCell")
        table.rowHeight = 50
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

