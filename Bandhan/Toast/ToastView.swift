//
//  Toast.swift
//  Bandhan
//
//  Created by Vivek on 7/18/25.
//

import SwiftUI

struct ToastView: View {
    let message: String
    
    var body: some View {
        HStack{
            Image(systemName: "checkmark.circle")
                .foregroundStyle(.green)
            Text(message)
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .foregroundColor(.white)
        .cornerRadius(30)
    }
}

#Preview {
    ToastView(message: "Profile ShortListed")
}
