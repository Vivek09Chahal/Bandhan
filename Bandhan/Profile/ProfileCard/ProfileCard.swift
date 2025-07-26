//
//  ProfileCard.swift
//  Bandhan
//
//  Created by Vivek on 6/30/25.
//

import SwiftUI

struct ProfileCard: View {
    
    var profile: ProfilesData
    @EnvironmentObject var homeVM: HomeViewModel
    
    var body: some View {
        ZStack{
            // MARK: - Image
            ProfilePhotoView(width: 1.1, height: 1.7, pic: profile.profilePicture.first!)
                .overlay(
                    ZStack {
                        // Gradient overlay
                        LinearGradient(
                            colors: [.clear, .black],
                            startPoint: .center,
                            endPoint: .bottom
                        )
                        
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
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
            // MARK: - top Section
            VStack(alignment: .leading){
                cardHeader
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
                        .managedBy()
                    
                    // Options
                    ActionButton(id: profile.id)
                }
                
            }
            .padding()
        }
        .frame(width: UIScreen.main.bounds.width/1.1, height: UIScreen.main.bounds.height/1.7)
    }
}

extension ProfileCard {
    
    var cardHeader: some View {
        HStack{
            // Compatibility
            Group{
                Image(systemName: "hand.thumbsup.fill")
                Text("Most Compatible")
                    .font(.caption)
            }
            .padding(10)
            .background{
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            
            // No. of pics uploaded
            Image(systemName: "photo.stack")
            Text("\(profile.profilePicture.count)")
        }
        .foregroundStyle(.white)
    }
    
    func details(info1: String, info2: String = "") -> some View {
        HStack{
            Text(info1)
            Text(info2)
        }
        .foregroundStyle(.white)
    }
}

#Preview {
    ProfileCard(profile: profilesPreview.instance.sampleProfile)
        .environmentObject(ActivityViewModel())
        .environmentObject(HomeViewModel())
}

struct TextShimmer: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 4)
            .fill(Color.gray.opacity(0.9))
            .frame(height: 24)
    }
}
