//
//  TabView.swift
//  Bandhan
//
//  Created by Vivek on 6/30/25.
//

import SwiftUI

struct Tabs: View {
    
    @State var showUserProfile: Bool = false
    
    var body: some View {
        ZStack(alignment: .leading){
            TabView{
                Tab("Matches", systemImage: "square.stack.3d.up.fill"){
                    HomeView(showUserProfile: $showUserProfile)
                }
                
                Tab("Activity", systemImage: "clock.fill"){
//                    HomeView()
                }
                
                Tab("Messages", systemImage: "message.fill"){
//                    HomeView()
                }
                
                Tab("Premium", systemImage: "checkmark.seal.fill"){
//                    HomeView()
                }
            }
            .ignoresSafeArea()
            .overlay(
                Color.black.opacity(showUserProfile ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showUserProfile = false
                        }
                    }
            )
            
            
            // MARK: - User Profile Menu
            UserProfileMenu()
                .frame(width: 300)
                .offset(x: showUserProfile ? 0 : -300)
                .animation(.spring(), value: showUserProfile)
        }
        .gesture(
            DragGesture()
                .onEnded { gesture in
                    if gesture.translation.width > 50 {
                        withAnimation(.spring()) {
                            showUserProfile = true
                        }
                    } else if gesture.translation.width < -50 {
                        withAnimation(.spring()) {
                            showUserProfile = false
                        }
                    }
                }
        )
    }
}

#Preview {
    Tabs()
}
