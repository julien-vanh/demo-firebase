//
//  View+customTextField.swift
//  DemoFirebase
//
//  Created by Julien Vanheule on 13/03/2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func customTextField(icon: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(.gray)
            
            self
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(.bar, in: .rect(cornerRadius: 10))
    }
}
