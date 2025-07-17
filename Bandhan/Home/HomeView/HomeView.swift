//
//  HomeView.swift
//  Bandhan
//
//  Created by Vivek on 6/30/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State var showFilterSheet: Bool = false
    @State var showingSearchView: Bool = false
    
    var body: some View {
        NavigationStack{
            ZStack(alignment: .leading){
                VStack{
                    HeaderView()
                        .padding(.horizontal)
                    Divider()
                    
                    // MARK: - Filter Section
                    filterButton
                    
                    // MARK: - Profile Scroll Section
                    VStack{
                        ScrollView {
                            LazyVStack {
                                allProfiles
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
            .sheet(isPresented: $showFilterSheet) {
                FilterOptionsView(filterViewModel: vm.filterViewModel)
            }
        }
    }
}

struct HomeView_Preview: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            HomeView()
        }
        .environmentObject(dev.profileVM)
        .environmentObject(HeaderViewManager())
    }
}

extension HomeView{
    
    private var allProfiles: some View {
        ForEach(vm.displayProfiles, id: \.id) { profile in
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
    
    var filterButton: some View {
        HStack {
            Button(action: {
                showFilterSheet = true
            }) {
                HStack {
                    Image(systemName: vm.filterViewModel.hasActiveFilters ? "line.horizontal.3.decrease.circle.fill" : "line.horizontal.3.decrease.circle")
                        .foregroundColor(vm.filterViewModel.hasActiveFilters ? .blue : .gray)
                    Text("Filter")
                        .font(.footnote)
                        .foregroundColor(vm.filterViewModel.hasActiveFilters ? .blue : .primary)
                    
                    if vm.filterViewModel.hasActiveFilters {
                        Text("(\(vm.filterViewModel.appliedFilters.count))")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
            }
            
            if vm.filterViewModel.hasActiveFilters {
                Button("Clear All") {
                    vm.filterViewModel.clearAllFilters()
                }
                .font(.footnote)
                .foregroundColor(.red)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.red.opacity(0.1))
                .cornerRadius(8)
            }
            
            Spacer()
            
            Text("\(vm.displayProfiles.count) profiles")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal)
        }
    }
    
}
