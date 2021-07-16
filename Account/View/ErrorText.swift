//
//  ErrorText.swift
//  Account
//
//  Created by echo on 7/15/21.
//

import SwiftUI

struct ErrorText: View {

    var error: String

    var body: some View {
        Text(error)
            .foregroundColor(.red)
            .font(.subheadline)
            .multilineTextAlignment(.leading)
    }
}

struct ErrorText_Previews: PreviewProvider {
    static var previews: some View {
        ErrorText(error: "User name must contain at least one symbol")
    }
}
