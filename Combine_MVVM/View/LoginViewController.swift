//
//  ViewController.swift
//  Combine_MVVM
//
//  Created by admin on 17/10/2022.
//

import UIKit
import Combine

class LoginViewController: UIViewController {
    @IBOutlet private var imgAvatr: UIImageView!
    @IBOutlet private var userTextField: UITextField!
    @IBOutlet private var emailTextFiedl: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var userError: UILabel!
    @IBOutlet private var emailError: UILabel!
    @IBOutlet private var passwordError: UILabel!
    @IBOutlet private var btLogin: UIButton!
    var subscriptions = Set<AnyCancellable>()
    let viewModel = LoginViewModel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        onBind()
    }
    
    private func setupUI() {
        setupImageAvatar()
        setupTextField()
        setupLb()
        setupBtLogin()
        
    }
    private func onBind() {
        viewModel.emailErrorPublisher.assign(to: \.text, on: emailError).store(in: &subscriptions)
        emailError.isHidden = false
        viewModel.userErrorPublisher.assign(to: \.text, on: userError).store(in: &subscriptions)
        userError.isHidden = false
        viewModel.passwordErrorPublisher.assign(to: \.text, on: passwordError).store(in: &subscriptions)
        passwordError.isHidden = false
        /// combinelatest
        Publishers.CombineLatest3(viewModel.userErrorPublisher.map{$0 == nil},
                                   viewModel.emailErrorPublisher.map{$0 == nil},
                                  viewModel.passwordErrorPublisher.map{$0 == nil}).map{$0.0 && $0.1 && $0.2}
            .assign(to: \.isEnabled, on: btLogin).store(in: &subscriptions)
    }
    
    private func setupImageAvatar() {
        imgAvatr.layer.cornerRadius = imgAvatr.frame.height / 2
        imgAvatr.layer.masksToBounds = true
    }
    private func setupTextField() {
        userTextField.attributedPlaceholder = NSAttributedString(string: "Enter User", attributes: [.foregroundColor: UIColor.systemBrown])
        userTextField.addTarget(self, action: #selector(didChangeTextField(_:)), for: .editingChanged)
        emailTextFiedl.attributedPlaceholder = NSAttributedString(string: "Enter your Email", attributes: [.foregroundColor: UIColor.systemBrown])
        emailTextFiedl.addTarget(self, action: #selector(didChangeTextField(_:)), for: .editingChanged)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Enter your password", attributes: [.foregroundColor: UIColor.systemBrown])
        passwordTextField.addTarget(self, action: #selector(didChangeTextField(_:)), for: .editingChanged)
    }
    
    private func setupLb() {
        emailError.textColor = .red
        emailError.isHidden = true
        passwordError.textColor = .red
        passwordError.isHidden = true
        userError.textColor = .red
        userError.isHidden = true
    }
    
    private func setupBtLogin() {
        btLogin.isEnabled = false
        btLogin.addTarget(self, action: #selector(didTapMoveHome), for: .touchUpInside)
    }
    @objc private func didChangeTextField(_ textField: UITextField) {
        if textField === userTextField {
            viewModel.userPublisher.send(textField.text ?? "")
        }else if textField === emailTextFiedl {
            viewModel.emailPublisher.send(textField.text ?? "")
        }else if textField === passwordTextField {
            viewModel.passwordPublisher.send(textField.text ?? "")
        }
        
    }
    @objc private func didTapMoveHome() {
        let vc = HomeViewController.instance()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    


}

