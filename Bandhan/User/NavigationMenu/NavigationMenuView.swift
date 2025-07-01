//
//  NavigationMenuView.swift
//  Bandhan
//
//  Created by Vivek on 7/1/25.
//

import SwiftUI

struct NavigationMenuView: View {
    
    @Binding var selectedMenu: UserMenu?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            ForEach(UserMenu.allCases) { item in
                Button {
                    selectedMenu = item
                } label: {
                    HStack(spacing: 15) {
                        Image(systemName: iconName(for: item))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                            .foregroundColor(.primary)
                        Text(item.rawValue)
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    private func iconName(for menu: UserMenu) -> String {
        switch menu {
        case .profile: return "person"
        case .savedMatches: return "bookmark"
        case .notifications: return "bell"
        case .messages: return "message"
        case .settings: return "gear"
        case .help: return "questionmark.circle"
        }
    }
}
//
//#Preview {
//    NavigationStack {
//        NavigationMenuView()
//    }
//}
