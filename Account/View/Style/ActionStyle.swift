//
//  ActionStyle.swift
//  Account
//
//  Created by echo on 7/16/21.
//

import Foundation
import SwiftUI

struct ActionStyle: ButtonStyle {


    private let cornerRadius: CGFloat = 8
    let backgroundColor: Color
    let titleColor: Color
    let isEnabled: Bool
    

    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
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
        
    }
}
