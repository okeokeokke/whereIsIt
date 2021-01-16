//
//  AddSubjectNamesViewController.swift
//  whereIsIt
//
//  Created by 桶本あいか on 2020/11/07.
//  Copyright © 2020 Okemoto.Okke. All rights reserved.
//

import UIKit
import RealmSwift

class AddSubjectNamesViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var uiTextField: UITextField!
    @IBOutlet var redButton: UIButton!
    var colorImage: UIImage?
    var imageName: String?
    var id: String?
    var button: UIButton?
    
    
    let realm = try!Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        uiTextField.delegate = self
        colorImage = UIImage(named: "redCircle.png")
        uiTextField.clearButtonMode = .unlessEditing
        uiTextField.delegate = self
        

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
    
    @IBAction func doneButton() {
        let subject = Subject()
        subject.name = uiTextField.text!
        subject.colorImage = colorImage!.pngData() as Data?
       
        try! self.realm.write {
            self.realm.add(subject)
        }
//        print(subject)
        let tabVc = self.presentingViewController as! UITabBarController
        let navigationVc = tabVc.selectedViewController as! UINavigationController
        let preVC = navigationVc.topViewController as! TextListViewController
//        let preVC = self.presentingViewController as! TextListViewController
         preVC.table.reloadData()
        self.dismiss(animated: true, completion: nil)
    
    }
    
    @IBAction func cancelButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func red() {
        
    }
    
    @IBAction private func didTapNumberButton(_ sender: UIButton) {
        
        colorImage = sender.currentBackgroundImage
//        print(type(of: colorImage))
//        print(sender.restorationIdentifier!)
        sender.setBackgroundImage(UIImage(named: sender.restorationIdentifier! + "2"), for: .normal)
        button?.setBackgroundImage(UIImage(named: id!), for: .normal)
        button = sender
        id = sender.restorationIdentifier
//        print(button)
//        print(id)
        
//        colorImage.restorationIdentifier
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
