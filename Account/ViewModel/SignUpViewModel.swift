//
//  ContentViewModel.swift
//  Account
//
//  Created by echo on 7/12/21.
//

import Foundation
import Combine
import SwiftUI

class SignUpViewModel: ObservableObject {

    //Input
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""

    //Output
    @Published var presentAlert = false
    @Published var isValidatedForm: Bool = false
    let colorTheme: Color = .green

    @Published var usernameMessage: String?
    @Published var passwordMessage: String?
    @Published var confirmPasswordMessage: String?

    private var cancellableSet: Set<AnyCancellable> = []

    init() {
        bindSubscribers()
    }

    // MARK: - Private Logic

    fileprivate var isValidatedUsername: AnyPublisher<Bool, Never> {
        $username
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .map({username in
                !username.isEmpty
            })
            .eraseToAnyPublisher()
    }

    fileprivate var isValidatedPassword: AnyPublisher<Bool, Never> {
        $password
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .map({password in
                password.count <= 8 && password.rangeOfCharacter(from: .decimalDigits) != nil
            })
            .eraseToAnyPublisher()
    }

    fileprivate var isValidatedConfirmPassword: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $confirmPassword)
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .map { password, confirmPassword in
                !confirmPassword.isEmpty && password == confirmPassword
            }
            .eraseToAnyPublisher()
    }

    fileprivate var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(isValidatedUsername, isValidatedPassword, isValidatedConfirmPassword)
            .map { (isValidatedUsername, isValidatedPassword, isValidatedConfirmPassword) in
                isValidatedUsername && isValidatedPassword && isValidatedConfirmPassword
            }
            .eraseToAnyPublisher()
    }

    fileprivate func resetFields() {
        username = ""
        password = ""
        confirmPassword = ""
    }

    private func bindSubscribers() {
        $presentAlert
            .sink { [weak self] (presentAlert) in
                if presentAlert {
                    self?.resetFields()
                }
            }
            .store(in: &cancellableSet)
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValidatedForm, on: self)
            .store(in: &cancellableSet)
        isValidatedUsername
            .receive(on: RunLoop.main)
            .map({ isValid in
                isValid ? nil : "Username must contain at leat one symbol"
            })
            .assign(to: \.usernameMessage, on: self)
            .store(in: &cancellableSet)
        isValidatedPassword
            .receive(on: RunLoop.main)
            .map { isValid in
                isValid ? nil : "Password must contain at least one digit and be less or equal then 8 symbols"
            }
            .assign(to: \.passwordMessage, on: self)
            .store(in: &cancellableSet)
        isValidatedConfirmPassword
            .receive(on: RunLoop.main)
            .map { isValid in
                isValid ? nil : "Password field and Confirm password field doesn't match"
            }
            .assign(to: \.confirmPasswordMessage, on: self)
            .store(in: &cancellableSet)
    }

}
