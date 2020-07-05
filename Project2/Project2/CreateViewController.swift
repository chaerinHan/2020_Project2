//
//  CreateViewController.swift
//  Project2
//
//  Created by SWUCOMPUTER on 2020/07/05.
//  Copyright © 2020 SWUCOMPUTER. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var createName: UITextField!
    @IBOutlet var createTableid: UITextField!
    @IBOutlet var createPassword: UITextField!
    @IBOutlet var labelStatus: UILabel!
    
    
    @IBAction func buttonSave() {
        if createName.text == "" {
            labelStatus.text = "테이블 번호를 입력하세요"; return; }
        if createTableid.text == "" {
            labelStatus.text = "Password를 입력하세요"; return; }
        if createPassword.text == "" {
            labelStatus.text = "사용자 이름을 입력하세요"; return; }
        
        let urlString: String = "http://condi.swu.ac.kr/student/T14/order/loginUser.php"
               guard let requestURL = URL(string: urlString) else {
                   return
               }
               var request = URLRequest(url: requestURL)
               request.httpMethod = "POST"
               let restString: String = "id=" + createTableid.text! + "&password=" + createPassword.text! + "&name=" + createName.text!
               request.httpBody = restString.data(using: .utf8)
               self.executeRequest(request: request)
    }
   
    func executeRequest (request: URLRequest) -> Void {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                print("Error: calling POST")
                return
            }
            guard let receivedData = responseData else {
                print("Error: not receiving Data")
                return
            }
            if let utf8Data = String(data: receivedData, encoding: .utf8) {
                DispatchQueue.main.async { // for Main Thread Checker
                    self.labelStatus.text = utf8Data
                    print(utf8Data) // php에서 출력한 echo data가 debug 창에 표시됨
                }
            }
        }
        task.resume()
        }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.createName {
            textField.resignFirstResponder()
            self.createTableid.becomeFirstResponder()
        }
        else if textField == self.createTableid{
            textField.resignFirstResponder()
            self.createPassword.becomeFirstResponder()
        }
        textField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
