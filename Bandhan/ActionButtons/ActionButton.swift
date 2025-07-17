//
//  ActionButton.swift
//  Bandhan
//
//  Created by Vivek on 7/2/25.
//

import SwiftUI

struct ActionButton: View {
    
    
    var id: String
    var activitiesVM: Activities = Activities()
    
    var body: some View {
        HStack{
            action(title: "Message", imageName: "envelope.badge.person.crop.fill", action: ())
            action(title: "Interested", imageName: "bolt.heart", action: ())
            action(title: "Shortlist", imageName: "star", action: activitiesVM.shortlistedProfilesID.append(id))
            action(title: "Chat", imageName: "message", action: ())
        }
    }
}

extension ActionButton {
    
    func action(title: String, imageName: String, action: ()) -> some View {
        Button {
            action
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
    ActionButton(id: "1122")
}
