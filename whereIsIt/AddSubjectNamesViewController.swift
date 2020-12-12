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
    
    let realm = try!Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        uiTextField.delegate = self
        colorImage = UIImage(named: "redCircle.png")
        uiTextField.clearButtonMode = .unlessEditing
        

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func doneButton() {
        let subject = Subject()
        subject.name = uiTextField.text!
        subject.colorImage = colorImage!.pngData() as Data?
       
        try! self.realm.write {
            self.realm.add(subject)
        }
        print(subject)
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
        print(type(of: colorImage))
            
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
