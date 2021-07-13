//
//  ContentViewModel.swift
//  Account
//
//  Created by echo on 7/12/21.
//

import Foundation

class SignUpViewModel: ObservableObject {

    @Published var username: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var presentAlert = false {
        willSet {
            if presentAlert {
                resetFields()
            }
        }
    }

    var isValidatedForm: Bool {
        return isValidatedUsername && isValidatedPassword && isValidatedConfirmPassword
    }

    // MARK: - Private Logic

    fileprivate var isValidatedUsername: Bool {
        return !username.isEmpty
    }

    fileprivate var isValidatedPassword: Bool {
        return password.count <= 8 && password.rangeOfCharacter(from: .decimalDigits) != nil
    }

    fileprivate var isValidatedConfirmPassword: Bool {
        return password == confirmPassword
    }

    fileprivate func resetFields() {
        username = ""
        password = ""
        confirmPassword = ""
    }

}
