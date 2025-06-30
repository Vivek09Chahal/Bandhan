//
//  HomeView.swift
//  Bandhan
//
//  Created by Vivek on 6/30/25.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var showUserProfile: Bool
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .leading){
                VStack{
                    // MARK: - Top Section
                    HeaderView(showUserProfile: $showUserProfile)
                        .padding(.horizontal)
                    Divider()
                    // MARK: - Filter View
                    FilterView()
                        .padding(.horizontal)
                    
                    // MARK: - Profile Scroll Section
                    VStack{
                        ScrollView {
                            LazyVStack {
                                ForEach(0..<10) { index in
                                    ProfileCard()
                                        .containerRelativeFrame(.vertical)
                                        .id(index)
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
    }
}
