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

    fileprivate let cornerRadius: CGFloat = 8

    var body: some View {
        Button(action: action, label: {
            Text(title)
                .font(.title3)
                .foregroundColor(
                    isEnabled ? titleColor : titleColor.opacity(0.6)
                )
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(titleColor, lineWidth: 0)
                        .background(backgroundColor)
                        .shadow(color: titleColor, radius: 5, x: 0, y: 0)
                )
                .cornerRadius(cornerRadius)
                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 5, y: 5)
        })
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(title: "Create a account", action: {}, backgroundColor: .green, titleColor: .white)
            .disabled(true)
    }
}
