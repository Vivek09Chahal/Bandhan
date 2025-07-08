//
//  HeaderView.swift
//  Bandhan
//
//  Created by Vivek on 6/30/25.
//

import SwiftUI

struct HeaderView: View {
    
    var title: String
    var headerDescription: String?
    @Binding var showUserProfile: Bool
    
    var body: some View {
        HStack(alignment: .top){
            // user proile pic
            Image("profilePic")
                .resizable()
                .frame(width: 50, height: 50)
                .scaledToFit()
                .clipShape(Circle())
                .onTapGesture {
                    showUserProfile.toggle()
                }
            
            // headline
            VStack(alignment: .leading){
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                Text(headerDescription ?? "")
                    .font(.subheadline)
            }
            Spacer()
            
            // Notification, Search
            HStack{
                Image(systemName: "bell")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.trailing)
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 25, height: 25)
            }
            .padding()
        }
    }
}

#Preview {
    HeaderView(title: "Matches", headerDescription: "as per partner preference", showUserProfile: .constant(true))
}
