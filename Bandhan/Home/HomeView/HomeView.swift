//
//  HomeView.swift
//  Bandhan
//
//  Created by Vivek on 6/30/25.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var showUserProfile: Bool
    @Environment(DataFetch.self) var dataFetch
    @State var showFilterSheet: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .leading){
                VStack{
                    // MARK: - Top Section
                    HeaderView(title: "Matches", headerDescription: "as per partner preference", showUserProfile: $showUserProfile)
                        .padding(.horizontal)
                    Divider()
                    
                    // MARK: - Filter View
                    FilterView(showFilterSheet: $showFilterSheet)
                        .padding(.horizontal)
                    
                    // MARK: - Profile Scroll Section
                    VStack{
                        if dataFetch.profiles.isEmpty {
                            VStack(spacing: 16) {
                                Image(systemName: "person.fill.questionmark")
                                    .font(.system(size: 60))
                                    .foregroundColor(.secondary)
                                
                                Text("No matches found")
                                    .font(.headline)
                                
                                Text("Try adjusting your filters to see more profiles")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .multilineTextAlignment(.center)
                                
                                Button {
                                    dataFetch.resetFilters()
                                } label: {
                                    Text("Reset Filters")
                                        .padding(.horizontal, 20)
                                        .padding(.vertical, 10)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(Color.blue)
                                        )
                                        .foregroundColor(.white)
                                }
                                .padding(.top, 10)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding()
                        } else {
                            ScrollView {
                                LazyVStack {
                                    ForEach(dataFetch.profiles, id: \.id) { profile in
                                        NavigationLink {
                                            ProfileInfoView(profile: profile)
                                        } label: {
                                            ProfileCard(profile: profile)
                                                .containerRelativeFrame(.vertical)
                                                .id(profile.id)
                                                .padding(.bottom)
                                        }
                                    }
                                }
                                .scrollTargetLayout()
                            }
                            .scrollTargetBehavior(.viewAligned)
                            .scrollIndicators(.hidden)
                            .padding()
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .sheet(isPresented: $showFilterSheet) {
                FilterSheetView()
            }
        }
    }
}

#Preview {
    NavigationStack{
        HomeView(showUserProfile: .constant(false))
            .environment(DataFetch())
    }
}
