//
//  ActivityViewModel.swift
//  Bandhan
//
//  Created by Vivek on 7/2/25.
//

import Foundation
import SwiftUI

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
    func navigateViewItem() -> some View {
        switch self {
        case .profileVisit:
            activityNumbers(text: "Profile Visit", color: .indigo, number: 12)
        case .shortlisted:
            activityNumbers(text: "Shortlisted", color: .yellow, number: 5)
        case .contactViews:
            activityNumbers(text: "Contact Views", color: .blue, number: 8)
        }
    }
    
    @ViewBuilder
    func navigateView() -> some View {
        switch self {
        case .profileVisit:
            activityNumbers(text: "Profile Visit", color: .indigo, number: 12)
        case .shortlisted:
            VStack{
                if Activities().shortlistProfiles.isEmpty{
                    VStack{
                        Text("No shortlisted profiles yet")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                } else {
                    VStack{
                        ForEach(Activities().shortlistProfiles, id: \.id){ profile in
                            ProfileCard(profile: profile)
                        }
                    }
                }
            }
        case .contactViews:
            activityNumbers(text: "Contact Views", color: .blue, number: 8)
        }
    }
}



class Activities {
    
    @EnvironmentObject var profileVM: HomeViewModel
    
    var sceneProfiles: [ProfilesData] = []
    var shortlistedProfilesID: [String] = []
    var contactedProfiles: [ProfilesData] = []
    
    var shortlistProfiles: [ProfilesData] = []
    
    func getSortlistedProfiles() -> [ProfilesData]{
        for profile in profileVM.allProfiles {
            if shortlistedProfilesID.contains(profile.id) {
                shortlistProfiles.append(profile)
            }
        }
        
        return shortlistProfiles
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

struct ReceivedView: View {
    var body: some View {
        Text("Received")
    }
}


struct AcceptedView: View {
    var body: some View {
        Text("Accepted")
    }
}


struct SentView: View {
    var body: some View {
        Text("Sent")
    }
}
