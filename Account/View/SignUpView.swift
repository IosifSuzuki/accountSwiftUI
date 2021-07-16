//
//  ContentView.swift
//  Account
//
//  Created by echo on 7/12/21.
//

import SwiftUI

struct SignUpView: View {

    @ObservedObject private var viewModel = SignUpViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "cloud")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 75)
                    .foregroundColor(.green)
                    .offset(y: 40)
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    EntryField(iconName: "person.crop.circle.badge.plus", placeholder: "Username", isSecure: false, colorTheme: viewModel.colorTheme, text: $viewModel.username)
                    if let usernameMessage = viewModel.usernameMessage {
                        ErrorText(error: usernameMessage)
                            .transition(.move(edge: .leading))
                            .animation(.easeOut)
                    }
                    EntryField(iconName: "lock", placeholder: "Password", isSecure: true, colorTheme: viewModel.colorTheme, text: $viewModel.password)
                    if let passwordMessage = viewModel.passwordMessage {
                        ErrorText(error: passwordMessage)
                            .transition(.move(edge: .leading))
                            .animation(.easeOut)
                    }
                    EntryField(iconName: "lock", placeholder: "Confirm", isSecure: true, colorTheme: viewModel.colorTheme, text: $viewModel.confirmPassword)
                    if let passwordConfirmed = viewModel.confirmPasswordMessage {
                        ErrorText(error: passwordConfirmed)
                            .transition(.move(edge: .leading))
                            .animation(.easeOut)
                    }
                }
                .autocapitalization(.none)
                ActionButton(title: "Create a account", action: {
                    viewModel.presentAlert.toggle()
                }, backgroundColor: viewModel.colorTheme, titleColor: .white)
                    .disabled(!viewModel.isValidatedForm)
                Spacer()
            }
            .padding([.leading, .trailing], 20)
            .alert(isPresented: $viewModel.presentAlert) {
                Alert(title: Text("Info"), message: Text("You are logged in successfully"), dismissButton: .default(Text("OK")))
            }
            .onTapGesture {
                dismissKeyboard()
            }
            .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .preferredColorScheme(.dark)
    }
}
