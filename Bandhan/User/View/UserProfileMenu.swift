//
//  UserProfileView.swift
//  Bandhan
//
//  Created by Vivek on 7/1/25.
//

import SwiftUI

struct UserProfileMenu: View {
    
    @Binding var showUserProfile: Bool
    @Binding var selectedMenu: UserMenu?
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20){
            // User Profile Image and Name
            VStack(spacing: 10) {
                
                // User profile Pic edit option still left
                Image("profilePic")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 80, height: 80)
                
                // User Name
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
            
            // MARK: - Navigation Menu Options
            NavigationMenuView(selectedMenu: $selectedMenu)
            
            Spacer()
            
            Divider()
            
            // MARK: - Logout Button
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
        .background(colorScheme == .dark ? Color.black : Color.white)
        .edgesIgnoringSafeArea(.bottom)
        }
    }
}

//#Preview {
//    UserProfileMenu()
//}
