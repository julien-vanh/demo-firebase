//
//  DefaultAvatarView.swift
//  DemoFirebase
//
//  Created by Julien Vanheule on 17/03/2024.
//

import SwiftUI

struct DefaultAvatar: View {
    var body: some View {
        Image(systemName: "person.circle.fill")
            .symbolRenderingMode(.monochrome)
            .foregroundStyle(.primary)
                .font(.system(size: 26))
        
    }
}

#Preview {
        DefaultAvatar()
}
