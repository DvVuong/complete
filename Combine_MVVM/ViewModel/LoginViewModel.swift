//
//  LoginViewModel.swift
//  Combine_MVVM
//
//  Created by admin on 17/10/2022.
//

import Foundation
import Combine
final class LoginViewModel {
    let userErrorPublisher = CurrentValueSubject<String?, Never>("")
    let emailErrorPublisher = CurrentValueSubject<String?, Never>("")
    let passwordErrorPublisher = CurrentValueSubject<String?, Never>("")
    
    
    let userPublisher = PassthroughSubject<String, Never>()
    let emailPublisher = PassthroughSubject<String, Never>()
    let passwordPublisher = PassthroughSubject<String, Never>()
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        
        userPublisher.map{self.validUser($0)}.sink { valiPari in
            self.userErrorPublisher.value = valiPari.1
        }.store(in: &subscriptions)
        
        emailPublisher.map{self.validEmail($0)}.sink { valiPari in
            self.emailErrorPublisher.value = valiPari.1
        }.store(in: &subscriptions)
        passwordPublisher.map{self.validPassword($0)}.sink { valiPari in
            self.passwordErrorPublisher.value = valiPari.1
        }.store(in: &subscriptions)
        
    }
    
    private func validUser(_ user: String) -> (Bool, String?){
        if user.isEmpty {
            return (false, "User can't Emty")
        }
        return (true, nil)
    }
    private func validEmail(_ email: String) ->(Bool, String?) {
        if email.isEmpty {
            return (false, "Email can't Emty")
        }
        if !isValidEmail(email: email) {
            return (false, "Email Malformed")
        }
        
        return (true, nil)
    }
    private func validPassword(_ password: String) -> (Bool, String?) {
        if password.isEmpty {
            return (false, "Password can't Emty")
        }
        return (true, nil)
    }
    
    private func isValidEmail(email: String) -> Bool {
        let emailregEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailregEx)
        return emailPred.evaluate(with: email)
    }
    
    
    
    
    
    
}
