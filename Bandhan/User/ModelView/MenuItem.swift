//
//  MenuItem.swift
//  Bandhan
//
//  Created by Vivek on 7/1/25.
//

import Foundation
import SwiftUI

// MARK: - will use cases to navigate through Profile Menu Items
enum UserMenu: String, Identifiable, CaseIterable, Equatable {
    var id: String { rawValue }
    case profile = "Profile"
    case savedMatches = "Saved Matches"
    case notifications = "Notifications"
    case messages = "Messages"
    case settings = "Settings"
    case help = "Help & Support"
    
    
    @ViewBuilder
    func destinationView() -> some View {
        switch self {
        case .profile:
            UserProfileView()
        case .savedMatches:
            SavedMatchesView()
        case .notifications:
            NotificationsView()
        case .messages:
            MessagesView()
        case .settings:
            SettingsView()
        case .help:
            HelpSupportView()
        }
    }
}


// default View for now
struct SavedMatchesView: View { var body: some View { Text("💾 Saved Matches").font(.largeTitle) } }
struct NotificationsView: View { var body: some View { Text("🔔 Notifications").font(.largeTitle) } }
struct MessagesView: View { var body: some View { Text("💬 Messages").font(.largeTitle) } }
struct SettingsView: View { var body: some View { Text("⚙️ Settings").font(.largeTitle) } }
struct HelpSupportView: View { var body: some View { Text("❓ Help & Support").font(.largeTitle) } }
