//
//  UserProfileView.swift
//  Bandhan
//
//  Created by Vivek on 7/1/25.
//

import SwiftUI

struct UserProfileMenu: View {
    
    @State var selectedMenu: UserMenu? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            // User Profile Image and Name
            VStack(spacing: 10) {
                Image("profilePic")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 80, height: 80)
                Text("Vivek")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("@vivek_profile")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                HStack(spacing: 20) {
                    HStack(spacing: 4) {
                        Text("120")
                            .fontWeight(.bold)
                        Text("Following")
                            .foregroundColor(.gray)
                    }
                    
                    HStack(spacing: 4) {
                        Text("25")
                            .fontWeight(.bold)
                        Text("Matches")
                            .foregroundColor(.gray)
                    }
                }
                .padding(.top, 4)
            }
            .padding(.horizontal)
            
            Divider()
            
            // Menu Options
            VStack(alignment: .leading, spacing: 25) {
                menuItem(icon: "person", text: "Profile")
                menuItem(icon: "bookmark", text: "Saved Matches")
                menuItem(icon: "bell", text: "Notifications")
                menuItem(icon: "message", text: "Messages")
                menuItem(icon: "gear", text: "Settings")
                menuItem(icon: "questionmark.circle", text: "Help & Support")
            }
            .padding(.horizontal)
            
            Spacer()
            
            Divider()
            
            // Logout Button
            Button(action: {
                // Logout action
            }) {
                HStack(spacing: 15) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .foregroundColor(.red)
                    Text("Logout")
                        .foregroundColor(.red)
                        .fontWeight(.medium)
                }
                .padding(.horizontal)
                .padding(.vertical, 10)
            }
        }
        .padding(.vertical)
        .frame(maxWidth: 300, maxHeight: .infinity, alignment: .leading)
        .background(.secondary)
        .edgesIgnoringSafeArea(.bottom)
    }
    
}

extension UserProfileMenu{
    
    private func menuItem(icon: String, text: String) -> some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(width: 22, height: 22)
                .foregroundColor(.primary)
            Text(text)
                .font(.headline)
                .foregroundColor(.primary)
        }
    }
    
}

#Preview {
    UserProfileMenu()
}
