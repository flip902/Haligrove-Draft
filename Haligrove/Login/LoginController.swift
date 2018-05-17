//
//  LoginController.swift
//  Haligrove
//
//  Created by Phillip Carlino on 2018-04-07.
//  Copyright © 2018 Phillip Carlino. All rights reserved.
//

import UIKit
import Firebase


class LoginController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = #colorLiteral(red: 0.568627451, green: 0.5254901961, blue: 0.3568627451, alpha: 1)
        
        
        
        view.addSubview(logoContainerView)
        logoContainerView.anchor(top: view.topAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 150)
        
        setupInputFields()
        
        view.addSubview(gotoSignUp)
        gotoSignUp.anchor(top: nil, right: view.rightAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor, paddingTop: 0, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 0, height: 50)
     }
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        stackView.anchor(top: logoContainerView.bottomAnchor, right: view.rightAnchor, bottom: nil, left: view.leftAnchor, paddingTop: 40, paddingRight: 20, paddingBottom: 0, paddingLeft: 20, width: 0, height: 140)
    }
    
    
    
    let logoContainerView: UIView = {
        
        
        
       let view = UIView()
        
        guard let customFont = UIFont(name: "Pineapple Bold Inline", size: UIFont.labelFontSize) else { fatalError("""
                Failed to load the "Pineapple Bold Inline" font.
                """
            )}
        
        let titleLogo = UILabel()
        titleLogo.font = UIFont.init(name: "Pineapple Bold Inline", size: 60)
        titleLogo.textColor = #colorLiteral(red: 0.8392156863, green: 0.7568627451, blue: 0.5137254902, alpha: 1)
        titleLogo.text = "Haligrove"
        titleLogo.layer.shadowColor = #colorLiteral(red: 0.07843137255, green: 0.06666666667, blue: 0.05098039216, alpha: 1)
        titleLogo.layer.shadowRadius = 1.0
        titleLogo.layer.shadowOpacity = 1.0
        titleLogo.layer.shadowOffset = CGSize(width: 3, height: 3)
        titleLogo.layer.masksToBounds = true
        
        
        
        
        view.addSubview(titleLogo)
        titleLogo.anchor(top: view.topAnchor, right: nil, bottom: nil, left: nil, paddingTop: 40, paddingRight: 0, paddingBottom: 0, paddingLeft: 0, width: 215, height: 110)
        titleLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.backgroundColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1) // #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
       
        return view
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9647058824, blue: 0.9450980392, alpha: 1)
        
        tf.font = UIFont.init(name: "Quicksand-Regular", size: 18)
        
        tf.textColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
        tf.borderStyle = .roundedRect
        tf.keyboardType = .emailAddress
        tf.autocapitalizationType = .none
        tf.delegate = self
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        
        tf.font = UIFont.init(name: "Quicksand-Regular", size: 18)
        
        tf.isSecureTextEntry = true
        tf.textColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
        tf.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.9647058824, blue: 0.9450980392, alpha: 1)
        tf.borderStyle = .roundedRect
        tf.delegate = self
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.tintColor = #colorLiteral(red: 0.07843137255, green: 0.06666666667, blue: 0.05098039216, alpha: 1)
        button.titleLabel?.font = UIFont.init(name: "Quicksand-Bold", size: 18)
        button.layer.cornerRadius = 5
        button.backgroundColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    @objc func handleLogin() {
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { (user, err) in
            if let err = err {
                print("Failed to sign in with email: ", err)
                return
            }
            
            print("Successfully logged back in with user:", user?.uid ?? "")
            
            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else { return }
            mainTabBarController.setupViewControllers()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func handleTextInputChange() {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        
        let isFormValid = password.count > 0 && email.count > 0 && email.contains("@")
        
        if isFormValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = #colorLiteral(red: 0.8392156863, green: 0.7568627451, blue: 0.5137254902, alpha: 1)
            loginButton.tintColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.4274509804, green: 0.337254902, blue: 0.2117647059, alpha: 1)
            loginButton.tintColor = #colorLiteral(red: 0.07843137255, green: 0.06666666667, blue: 0.05098039216, alpha: 1)
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            view.endEditing(true)
        }
        return true
    }
    
    let gotoSignUp: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account? ", attributes: [NSAttributedStringKey.font: UIFont.init(name: "Quicksand-Medium", size: 14) ?? UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.968627451, green: 0.9647058824, blue: 0.9450980392, alpha: 1)])
        button.setAttributedTitle(attributedTitle, for: .normal)
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedStringKey.font: UIFont.init(name: "Quicksand-Bold", size: 14) ?? UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.8392156863, green: 0.7568627451, blue: 0.5137254902, alpha: 1)]))
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        
        return button
    }()
    
    @objc func handleShowSignUp() {
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

}
