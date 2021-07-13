//
//  ContentView.swift
//  Account
//
//  Created by echo on 7/12/21.
//

import SwiftUI

struct SignUpView: View {

    @ObservedObject var viewModel = SignUpViewModel()

    fileprivate let colorTheme: Color = .green

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
                VStack(spacing: 10) {
                    EntryField(iconName: "person.crop.circle.badge.plus", placeholder: "Username", isSecure: false, colorTheme: colorTheme, text: $viewModel.username)
                    EntryField(iconName: "lock", placeholder: "Password", isSecure: true, colorTheme: colorTheme, text: $viewModel.password)
                    EntryField(iconName: "lock", placeholder: "Confirm", isSecure: true, colorTheme: colorTheme, text: $viewModel.confirmPassword)
                }
                .autocapitalization(.none)
                ActionButton(title: "Create a account", action: {
                    viewModel.presentAlert.toggle()
                }, backgroundColor: colorTheme, titleColor: .white)
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

    fileprivate func dismissKeyboard() {
       UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .preferredColorScheme(.dark)
    }
}
