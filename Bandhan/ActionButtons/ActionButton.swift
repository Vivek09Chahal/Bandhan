//
//  ActionButton.swift
//  Bandhan
//
//  Created by Vivek on 7/2/25.
//

import SwiftUI

struct ActionButton: View {
    
    var body: some View {
        HStack{
            action(title: "Message", imageName: "envelope.badge.person.crop.fill")
            action(title: "Interested", imageName: "bolt.heart")
            action(title: "Shortlist", imageName: "star")
            action(title: "Chat", imageName: "message")
        }
    }
}

extension ActionButton {
    
    func action(title: String, imageName: String) -> some View {
        Button {
            //
        } label: {
            VStack{
                HStack{
                    Image(systemName: imageName)
                        .frame(width: 30, height: 25)
                        .foregroundColor(.white)
                        .padding()
                        .background{
                            Circle().fill(Color.red.opacity(0.5))
                        }
                }
                Text(title)
                    .font(.caption2)
            }
            .padding(.trailing)
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    ActionButton()
}
