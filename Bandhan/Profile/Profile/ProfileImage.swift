//
//  ProfileImages.swift
//  Bandhan
//
//  Created by Vivek on 7/14/25.
//

import SwiftUI

struct ProfileImage: View {
    
    var profile: ProfilesData
    @Environment(\.dismiss) var dismiss
    @State var picsSheet: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom){
            ProfilePhotoView(height: 2.3, pic: profile.profilePicture.first!)
            .clipped()
            // MARK: - Basic Info Section
            profileTitle
        }
        .sheet(isPresented: $picsSheet){
            ImageAnimation(profile: profile)
        }
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(){
                HStack{
                    HStack{
                        Image(systemName: "photo.on.rectangle.angled")
                        Text("\(profile.profilePicture.count)")
                            .padding(.trailing)
                    }
                    .onTapGesture {
                        picsSheet.toggle()
                    }
                    Image(systemName: "ellipsis")
                        .rotationEffect(Angle(degrees: 90))
                }
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .padding(11)
                        .background{
                            Circle()
                                .foregroundStyle(.quinary)
                        }
                        .foregroundStyle(.white)
                }
            }
        }
    }
}

extension ProfileImage {
    
    var profileTitle: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack{
                VStack(alignment: .leading) {
                    Text("\(profile.name), \(profile.age)")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("ID - \(profile.id)")
                        .font(.callout)
                }
                .padding(.vertical ,7)
                Spacer()
            }
            
            Text("Profile managed by Parent")
                .managedBy()
        }
        .foregroundStyle(.white)
        .padding()
    }
    
}
