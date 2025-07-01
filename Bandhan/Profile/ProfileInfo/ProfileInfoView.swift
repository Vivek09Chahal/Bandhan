//
//  ProfileInfoView.swift
//  Bandhan
//
//  Created by Vivek on 7/2/25.
//

import SwiftUI

struct ProfileInfoView: View {
    
    var profile: ProfilesData
    
    var body: some View {
        ScrollView{
            ZStack{
                AsyncImage(url: URL(string: profile.profilePicture)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: UIScreen.main.bounds.height/1.6)
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                }
                .overlay(
                    // Gradient overlay
                    LinearGradient(
                        colors: [.clear, .black],
                        startPoint: .center,
                        endPoint: .bottom
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                )
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Text(profile.name)
                
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ProfileInfoView(profile: ProfilesData.sampleProfile)
}
