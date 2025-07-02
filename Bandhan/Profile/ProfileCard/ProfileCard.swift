//
//  ProfileCard.swift
//  Bandhan
//
//  Created by Vivek on 6/30/25.
//

import SwiftUI

struct ProfileCard: View {
    
    var profile: ProfilesData
    
    var body: some View {
        ZStack(){
            
            // MARK: - Image
            AsyncImage(url: URL(string: profile.profilePicture)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height/1.6)
            } placeholder: {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                ZStack {
                    // Gradient overlay
                    LinearGradient(
                        colors: [.clear, .black],
                        startPoint: .center,
                        endPoint: .bottom
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    // Border stroke
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            LinearGradient(
                                colors: [.red, .orange, .pink],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            lineWidth: 2
                        )
                }
            )
            
            // MARK: - top Section
            VStack(alignment: .leading){
                HStack{
                    // Compatibility
                    Group{
                        Image(systemName: "hand.thumbsup.fill")
                        Text("Most Compatible")
                    }
                    .font(.caption)
                    .padding(10)
                    .background{
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    
                    // No. of pics uploaded
                    Image(systemName: "photo.stack")
                    Text("4")
                }
                .foregroundStyle(.white)
                
                Spacer()
                
                // MARK: - Details
                VStack(alignment: .leading){
                    details(info1: profile.name, info2: "\(profile.age)") // name, age
                        .font(.title)
                    details(info1: profile.height, info2: profile.location + profile.caste) // Height, Destination, Cast
                    details(info1: profile.profession, info2: profile.income)
                    details(info1: profile.education)
                    details(info1: "Profile Manager by Herself") // Profile Manager By Whom
                        .padding(.vertical, 8)
                        .background{
                            Rectangle()
                                .foregroundStyle(LinearGradient(colors: [.orange, .clear], startPoint: .leading, endPoint: .trailing).opacity(0.4))
                                .frame(width: UIScreen.main.bounds.width/1.1, height: 30)
                                .offset(x: 65)
                        }
                    
                    // Options
                    ActionButton()
                }
                
            }
            .padding()
        }
        .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height/1.6)
    }
}

extension ProfileCard {
    
    // detail Section
    func details(info1: String, info2: String = "") -> some View {
        HStack{
            Text(info1)
            Text(info2)
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    ProfileCard(profile: ProfilesData.sampleProfile)
}
