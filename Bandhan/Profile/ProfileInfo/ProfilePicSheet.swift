//
//  ProfilePicSheet.swift
//  Bandhan
//
//  Created by Vivek on 7/3/25.
//

import SwiftUI

struct ProfilePicsSheet: View {
    
    var profile: ProfilesData
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView(.horizontal){
            LazyHStack{
                ForEach(profile.profilePicture, id: \.self){ pic in
                    ProfilePhotoView(width: 1.1, height: 1.6, pic: pic)
                        .padding()
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .scrollTransition( axis: .horizontal ) { content, phase in return content
                                .offset(x: phase.value * -250)
                        }
                        .containerRelativeFrame(.horizontal)
                        .clipShape (RoundedRectangle(cornerRadius: 32))
                }
            }
        }
        .background{
            ProfilePhotoView(pic: profile.profilePicture.first!)
                .blur(radius: 20)
                .ignoresSafeArea()
        }
        .onTapGesture {
            dismiss()
        }
    }
}

#Preview{
    ProfilePicsSheet(profile: ProfilesData.sampleProfile)
}
