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
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .leading){
                VStack{
                    // MARK: - Top Section
                    HeaderView(showUserProfile: $showUserProfile, )
                        .padding(.horizontal)
                    Divider()
                    // MARK: - Filter View
                    FilterView()
                        .padding(.horizontal)
                    
                    // MARK: - Profile Scroll Section
                    VStack{
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
                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
