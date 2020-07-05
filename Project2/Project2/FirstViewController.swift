//
//  FirstViewController.swift
//  Project2
//
//  Created by SWUCOMPUTER on 2020/07/05.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData
struct Order{
    var menu: String!
    var size: String!
    var extra: String!
}

class FirstViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    let menuArray:Array<String> = ["포테이토 피자", "토마토 스파게티", "아메리카노", "사이다"]
    let sizeArray:Array<String> = ["1", "2", "3", "4"]
    
    // component 몇개 필요한지
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    // 라인 몇개 필요한지
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return menuArray.count
        }
        else {
            return sizeArray.count
        }
    }
    func pickerview(_pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0{
            return menuArray[row]
        }
        else{
            return sizeArray[row]
        }
    }

    @IBOutlet var menuPicker: UIPickerView!
    @IBOutlet var menuSize: UISegmentedControl!
    @IBOutlet var menuExtra: UITextField!
    @IBOutlet var labelStatus: UILabel!
    
    @IBAction func buttonOrder() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        var structOrder = Order()
        structOrder.menu = menuArray[self.menuPicker.selectedRow(inComponent: 0)] + sizeArray[self.menuPicker.selectedRow(inComponent: 1)]
        structOrder.extra = menuExtra.text!
     //   appDelegate.order.append(structOrder)
        
        
        let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as! SceneDelegate
        let tabController = sceneDelegate.window?.rootViewController as! UITabBarController
        let menuTab = tabController.tabBar.items![2]
        menuTab.badgeValue = String(format: "%d", appDelegate.order.count)
        // menu badge에 +1 하기
        appDelegate.menuCount += 1
        self.menuTab.badgeValue = String(format: "%d", appDelegate.menuCount)
    }
    
    // 다음 화면으로 갈 땨 showVC에서 보여질 내용들
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toShowView" {
            let destVC = segue.destination as! ShowViewController
            let menu: String! = String(menuPicker.selectedRow(inComponent: 0))
            let quan: String! = String(menuPicker.selectedRow(inComponent: 1))
            let size: String! = menuSize.titleForSegment (at: menuSize.selectedSegmentIndex)
            destVC.labelMenu.text = menu + quan + size
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }



}

