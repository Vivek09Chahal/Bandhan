//
//  ActivityView.swift
//  Bandhan
//
//  Created by Vivek on 7/18/25.
//

import SwiftUI

// MARK: - Activity Detail Views
struct ProfileVisitView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "eye")
                    .font(.system(size: 60))
                    .foregroundColor(.indigo)
                
                Text("Profile Visits")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("12 profiles have visited your profile recently")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Profile Visits")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ShortlistedProfilesView: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var activityVM: ActivityViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 15) {
                    if activityVM.shortlistedProfiles.isEmpty {
                        VStack(spacing: 20) {
                            Image(systemName: "heart.slash")
                                .font(.system(size: 60))
                                .foregroundColor(.gray)
                            
                            Text("No Shortlisted Profiles")
                                .font(.title2)
                                .fontWeight(.semibold)
                            
                            Text("Start browsing profiles and shortlist the ones you like!")
                                .font(.body)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 300)
                    } else {
                        ForEach(activityVM.shortlistedProfiles, id: \.id) { profile in
                            NavigationLink(destination: ProfileInfoView(profile: profile)) {
                                ProfileCard(profile: profile)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Shortlisted")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContactViewsView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "phone")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                Text("Contact Views")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("8 contacts have been viewed")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                
                Spacer()
            }
            .padding()
            .navigationTitle("Contact Views")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
