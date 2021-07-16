//
//  View+Extension.swift
//  Account
//
//  Created by echo on 7/16/21.
//

import Foundation
import SwiftUI

extension View {

    func dismissKeyboard() {
       UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }

}
