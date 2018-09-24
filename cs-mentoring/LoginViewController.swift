//
//  LoginViewController.swift
//  cs-mentoring
//
//  Created by Patricia Figueroa on 25/04/18.
//  Copyright © 2018 Patricia Figueroa. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  @IBOutlet weak var continueButton: UIButton!
  @IBOutlet weak var loginWithFacebookButton: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()
        configureLayer(layer: emailTextField.layer)
        configureLayer(layer: passwordTextField.layer)
        configureLayer(layer: continueButton.layer)
        configureLayer(layer: loginWithFacebookButton.layer)
        emailTextField.layer.sublayerTransform = CATransform3DMakeTranslation(20, 0, 0)
        passwordTextField.layer.sublayerTransform = CATransform3DMakeTranslation(20, 0, 0)
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
  
  func configureLayer(layer: CALayer) {
    layer.cornerRadius = layer.bounds.height/2;
    layer.borderColor = UIColor (red: 0.0, green: 122.0/255/0, blue: 1/0, alpha: 1.0).cgColor
    layer.borderWidth = 0.5;
  }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      navigationController?.navigationBar.isHidden = false;
    }
  
  func showAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }

  @IBAction func handleContinue(_ sender: UIButton) {
    sender.isEnabled = false;
    let username = emailTextField.text
    let password = passwordTextField.text
    
    let headers = [
      "content-type": "application/json",
      "cache-control": "no-cache"
    ]
    
    let parameters = [
      "password": password,
      "username": username
      ] as [String : String?]
    let postData = try? JSONSerialization.data(withJSONObject: parameters, options: [])
    let request = NSMutableURLRequest(url: NSURL(string: "https://csmentoring.herokuapp.com/auth/login")! as URL,
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
    
    if let window = UIApplication.shared.keyWindow {
        let tabViewController = HomeScreenNavigationController()
        window.rootViewController = tabViewController
    }
     //performSegue(withIdentifier: "loginSuccess", sender: nil)
  }
}
