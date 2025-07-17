//
//  modifiers.swift
//  Bandhan
//
//  Created by Vivek on 7/14/25.
//

import Foundation
import SwiftUI

struct managedByModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.vertical, 8)
            .background{
                Rectangle()
                    .foregroundStyle(LinearGradient(colors: [.orange, .clear], startPoint: .leading, endPoint: .trailing).opacity(0.4))
                    .frame(width: UIScreen.main.bounds.width/1.1, height: 30)
                    .offset(x: 65)
            }
    }
}

extension View {
    public func managedBy() -> some View {
        modifier(managedByModifier())
    }
}
