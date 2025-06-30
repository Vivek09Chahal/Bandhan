//
//  HeaderView.swift
//  Bandhan
//
//  Created by Vivek on 6/30/25.
//

import SwiftUI

struct HeaderView: View {
    
    @Binding var showUserProfile: Bool
    
    var body: some View {
        HStack(alignment: .top){
            Image("profilePic")
                .resizable()
                .frame(width: 50, height: 50)
                .scaledToFit()
                .clipShape(Circle())
                .onTapGesture {
                    showUserProfile.toggle()
                }
            VStack(alignment: .leading){
                Text("My Matches")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("as per partner preference")
                    .font(.subheadline)
            }
            Spacer()
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
    HeaderView(showUserProfile: .constant(true))
}
