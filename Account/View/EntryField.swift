//
//  EntryField.swift
//  Account
//
//  Created by echo on 7/12/21.
//

import SwiftUI

struct EntryField: View {

    private let cornerRadius: CGFloat = 8

    let iconName: String
    let placeholder: String
    let isSecure: Bool
    let colorTheme: Color

    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(colorTheme)
                .font(.headline)
            if isSecure {
                SecureField(placeholder, text: $text)
                    .accentColor(colorTheme)
            } else {
                TextField(placeholder, text: $text)
                    .accentColor(colorTheme)
                    .textContentType(.givenName)
            }
        }
        .padding(10)
        .background(Color.gray.opacity(0.15))
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(colorTheme, lineWidth: 1)
        )
    }
}

struct EntryField_Previews: PreviewProvider {

    static var previews: some View {
        EntryField(
            iconName: "lock",
            placeholder: "Your password",
            isSecure: true,
            colorTheme: .green,
            text: .constant("")
        )
            .previewLayout(.sizeThatFits)
        EntryField(
            iconName: "lock",
            placeholder: "Your name",
            isSecure: false,
            colorTheme: .green,
            text: .constant("")
        )
            .previewLayout(.sizeThatFits)
    }

}
