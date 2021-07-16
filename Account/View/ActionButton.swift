//
//  ActionButton.swift
//  Account
//
//  Created by echo on 7/12/21.
//

import SwiftUI

struct ActionButton: View {

    @Environment(\.isEnabled) private var isEnabled: Bool
    
    var title: String
    var action: () -> Void
    var backgroundColor: Color
    var titleColor: Color

    var body: some View {
        Button(action: action, label: {
            Text(title)
        })
        .buttonStyle(ActionStyle(
            backgroundColor: backgroundColor,
            titleColor: titleColor,
            isEnabled: isEnabled
        ))
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(title: "Create a account", action: {}, backgroundColor: .green, titleColor: .white)
            .disabled(true)
    }
}
