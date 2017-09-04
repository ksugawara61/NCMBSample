//
//  ViewController.swift
//  NCMBSample
//
//  Created by 菅原勝也 on 2017/09/05.
//  Copyright © 2017年 instil. All rights reserved.
//

import UIKit
import NCMB

class ViewController: UIViewController {
    
    @IBOutlet var sampleTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func save() {
        let object = NCMBObject(className: "Message")
        object?.setObject(sampleTextField.text, forKey: "text")
        object?.saveInBackground({ (error) in
            if error != nil {
                // エラー発生時
                print("*error*")
            } else {
                // 保存成功時
                print("success")
            }
        })
    }
    
    @IBAction func read() {
        let query = NCMBQuery(className: "Message")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                // エラー発生時
                print("*error*")
            } else {
                // データ取得時
                let messages = result as! [NCMBObject]
                let text = messages.last?.object(forKey: "text") as! String
                
                self.sampleTextField.text = text
            }
        })
    }
    
    @IBAction func update() {
        let query = NCMBQuery(className: "Message")
        query?.whereKey("text", equalTo: "こんばんは")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                print("*error")
            } else {
                let messages = result as! [NCMBObject]
                let textObject = messages.first
                textObject?.setObject("おやすみ", forKey: "text")
                textObject?.saveInBackground({ (error) in
                    if error != nil {
                        print("*error*")
                    } else {
                        print("update success")
                    }
                })
            }
        })
    }
    
    @IBAction func delete() {
        let query = NCMBQuery(className: "Message")
        query?.whereKey("text", equalTo: "test")
        query?.findObjectsInBackground({ (result, error) in
            if error != nil {
                print("*error*")
            } else {
                let messages = result as! [NCMBObject]
                let textObject = messages.first
                textObject?.deleteInBackground({ (error) in
                    if error != nil {
                        print("*error*")
                    } else {
                        print("delete success")
                    }
                })
            }
        })
    }

}

