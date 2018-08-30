//
//  SignUpViewController.swift
//  cs-mentoring
//
//  Created by Patricia Figueroa on 24/04/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
  @IBOutlet weak var fullNameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!

  @IBOutlet weak var usernameTextField: UITextField!
  
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var selectAnOptionButton: UIButton!
  
  @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
  @IBOutlet weak var contactTextField: UITextField!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setBorder(fullNameTextField.layer)
    setBorder(emailTextField.layer)
    setBorder(passwordTextField.layer)
    setBorder(usernameTextField.layer)
    setBorder(contactTextField.layer)
    setBorder(selectAnOptionButton.layer)
    
    selectAnOptionButton.layer.sublayerTransform = CATransform3DMakeTranslation(20, 0, 0)
    
    navigationController?.title = "Create an Account"
    
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
    view.addGestureRecognizer(tap)
    
  }
  
  func setBorder(_ layer: CALayer) {
    layer.borderColor = UIColor (red: 0.0, green: 122.0/255/0, blue: 1/0, alpha: 1.0).cgColor
    layer.borderWidth = 0.5
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.isHidden = false;
  }
  
  @IBAction func handleSelectAnOption(_ sender: Any) {
    let alert = UIAlertController(title: "I am a ...", message: "", preferredStyle: .actionSheet);
    alert.addAction(UIAlertAction(title: "Student", style: .default, handler: { _ in
      self.selectAnOptionButton.setTitle("Student", for: .normal)
    }))
    alert.addAction(UIAlertAction(title: "Mentor", style: .default, handler: { _ in
      self.selectAnOptionButton.setTitle("Mentor", for: .normal)
    }))
    alert.addAction(UIAlertAction(title: "Employee/Admin", style: .default, handler: { _ in
      self.selectAnOptionButton.setTitle("Employee/Admin", for: .normal)
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  func showAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
  @IBAction func handleContinue(_ sender: UIButton) {
    sender.isEnabled = false;
    let name = fullNameTextField.text
    let email = emailTextField.text
    let password = passwordTextField.text
    let username = usernameTextField.text
    let contact = contactTextField.text
    let userType = selectAnOptionButton.title(for: .normal)
    
    let headers = [
      "content-type": "application/json",
      "cache-control": "no-cache"
    ]
    
    let parameters = [
      "name": name,
      "password": password,
      "userType": userType,
      "email": email,
      "username": username,
      "contact": contact
      ] as [String : String?]
    let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
    let request = NSMutableURLRequest(url: NSURL(string: "https://csmentoring.herokuapp.com/auth/signup")! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "POST"
    request.allHTTPHeaderFields = headers
    request.httpBody = postData
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
      DispatchQueue.main.async {
        sender.isEnabled = true;
        if (error != nil) {
          self.showAlert(title: "Error", message: (error?.localizedDescription)!)
        } else {
          do {
            let responseJson = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
            if (responseJson["state"] as! String == "success") {
              let user = responseJson["user"] as! NSDictionary
              self.openProfile(userType: user.value(forKey: "userType") as! String)
            } else {
              self.showAlert(title: "Success", message: responseJson.description)
            }
          } catch let error as NSError {
            print(error)
          }
        }
      }
    })
    dataTask.resume()
    
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }

  func openProfile(userType: String) {
    UserDefaults.standard.set(userType, forKey: "userType")
    performSegue(withIdentifier: "signUpSuccess", sender: nil)
  }
}
