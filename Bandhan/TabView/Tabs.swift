//
//  TabView.swift
//  Bandhan
//
//  Created by Vivek on 6/30/25.
//

import SwiftUI

struct Tabs: View {
    
    @State private var selectedMenu: UserMenu? = nil
    @EnvironmentObject private var objectVM: ObjectManagers
    
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .leading){
                TabView(selection: $objectVM.selectedTab){
                    Tab("Matches", systemImage: "square.stack.3d.up.fill", value: 0){
                        HomeView()
                    }
                    
                    Tab("Activity", systemImage: "clock.fill", value: 1){
                        ActivityView()
                    }
                    
                    Tab("Messages", systemImage: "message.fill", value: 2){
                        ChatView()
                    }
                    
                    Tab("Membership", systemImage: "checkmark.seal.fill", value: 3){
                        MembershipView()
                    }
                }
                .ignoresSafeArea()
                .overlay(
                    Color.black.opacity(objectVM.showUserProfile ? 0.5 : 0)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.spring()) {
                                objectVM.showUserProfile = false
                            }
                        }
                )
                
                // MARK: - User Profile Menu
                if objectVM.showUserProfile {
                    sideBar
                }
            }
            // MARK: - Navigate to Menu Item
            .navigationDestination(item: $selectedMenu) { menu in
                menu.destinationView()
            }
            .gesture(
                DragGesture()
                    .onEnded { gesture in
                        if gesture.translation.width > 50 {
                            withAnimation(.spring()) {
                                objectVM.showUserProfile = true
                            }
                        } else if gesture.translation.width < -50 {
                            withAnimation(.spring()) {
                                objectVM.showUserProfile = false
                            }
                        }
                    }
            )
        }
    }
}

#Preview {
    Tabs()
        .environmentObject(HomeViewModel())
        .environmentObject(ObjectManagers())
        .environmentObject(ActivityViewModel())
}

extension Tabs {
    
    var sideBar: some View {
        UserProfileMenu(
            selectedMenu: $selectedMenu
        )
        .frame(width: 300)
        .transition(.move(edge: .leading))
        .zIndex(1)    }
    
}
