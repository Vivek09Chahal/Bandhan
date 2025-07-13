//
//  HomeView.swift
//  Bandhan
//
//  Created by Vivek on 6/30/25.
//

import SwiftUI

struct HomeView: View {
    
    @Environment(DataFetch.self) var dataFetch
    @State var showFilterSheet: Bool = false
    @State var showingSearchView: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .leading){
                VStack{
                    HeaderView()
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
                                
                                Text("Sorry it's not on you, It's on Us")
                                    .font(.headline)
                                
                                Text("No matches found")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
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
        HomeView()
            .environment({
                let dataFetch = DataFetch()
                // Load sample data for preview
                dataFetch.profileDataLoad(jsonFileName: "ProfilesData")
                return dataFetch
            }())
    }
}
