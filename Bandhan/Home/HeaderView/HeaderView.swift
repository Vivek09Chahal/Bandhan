//
//  HeaderView.swift
//  Bandhan
//
//  Created by Vivek on 6/30/25.
//

import SwiftUI

struct HeaderView: View {
    
    @EnvironmentObject var tabManager: ObjectManagers
    @State var isSearchBarActive: Bool = false
    
    var body: some View {
        HStack(alignment: .top){
            imageState
            headlineState
            Spacer()
            notificationState
        }
    }
}

#Preview {
    HeaderView()
        .environmentObject(ObjectManagers())
}

extension HeaderView{
    var imageState: some View {
        Image("profilePic")
            .resizable()
            .frame(width: 50, height: 50)
            .scaledToFit()
            .clipShape(Circle())
            .onTapGesture {
                tabManager.showUserProfile.toggle()
            }
    }
    
    var headlineState: some View {
        VStack(alignment: .leading){
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
            Text(headerDescription)
                .font(.subheadline)
        }
    }
    
    var notificationState: some View {
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


extension HeaderView{
    
    private var title: String {
        switch tabManager.selectedTab {
        case 0: return "Matches"
        case 1: return "Activity"
        case 2: return "Chat"
        case 3: return "Membership"
        default: return "Matches"
        }
    }
    
    private var headerDescription: String {
        switch tabManager.selectedTab {
        case 0: return "as per partner preference"
        case 1: return "your recent activity"
        case 2: return "conversations"
        case 3: return "upgrade your experience"
        default: return "as per partner preference"
        }
    }
    
}
