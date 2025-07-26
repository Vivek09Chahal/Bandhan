//
//  ActivityViewModel.swift
//  Bandhan
//
//  Created by Vivek on 7/2/25.
//

import Foundation
import SwiftUI
import Combine

enum ActivityCaseIters: String, CaseIterable{
    case received, accepted, sent
    
    var activityTitle: String{
        switch self {
        case .received:
            return "Received"
        case .accepted:
            return "Accepted"
        case .sent:
            return "Sent"
        }
    }
    
    @ViewBuilder func activityContent() -> some View {
        switch self {
        case .received:
            ReceivedView()
        case .accepted:
            AcceptedView()
        case .sent:
            SentView()
        }
    }
}

enum ActivityCases: String, CaseIterable{
    case profileVisit, shortlisted, contactViews
    
    @ViewBuilder
    func navigateViewItem(activityVM: ActivityViewModel) -> some View {
        switch self {
        case .profileVisit:
            activityNumbers(text: "Profile Visit", color: .indigo, number: 12)
        case .shortlisted:
            activityNumbers(text: "Shortlisted", color: .yellow, number: activityVM.shortlistedProfilesID.count)
        case .contactViews:
            activityNumbers(text: "Contact Views", color: .blue, number: 8)
        }
    }
    
    @ViewBuilder
    func navigateView() -> some View {
        switch self {
        case .profileVisit:
            ProfileVisitView()
        case .shortlisted:
            ShortlistedProfilesView()
        case .contactViews:
            ContactViewsView()
        }
    }
}

class ActivityViewModel: ObservableObject {
    
    var homeVM: HomeViewModel?
    @Published var shortlistedProfilesID: [String] = []
    
    var shortlistedProfiles: [ProfilesData] {
        guard let homeVM = homeVM else { return [] }
        let profiles = homeVM.allProfiles.filter { shortlistedProfilesID.contains($0.id) }
        return profiles
    }
    
    func addToShortlist(_ profileID: String) {
        if !shortlistedProfilesID.contains(profileID) {
            shortlistedProfilesID.append(profileID)
        }
    }
    
    func removeFromShortlist(_ profileID: String) {
        if let index = shortlistedProfilesID.firstIndex(of: profileID) {
            shortlistedProfilesID.remove(at: index)
        }
    }
}

// MARK: - Need to seprate
struct activityNumbers: View {
    
    var text: String
    var color: Color
    var number: Int
    
    var body: some View{
        VStack(alignment: .center) {
            Text("\(number)")
                .font(.title2)
                .fontWeight(.bold)
                .padding()
                .background {
                    Circle()
                        .foregroundStyle(color.opacity(0.2))
                }
                .padding(.bottom, 5)
            
            Text(text)
                .font(.caption)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 15)
                .foregroundStyle(.quinary)
                .shadow(radius: 2)
        }
        .frame(width: UIScreen.main.bounds.width/3.3, height: 120)
    }
}
