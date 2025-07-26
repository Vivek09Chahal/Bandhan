//
//  ProfileInfoView.swift
//  Bandhan
//
//  Created by Vivek on 7/2/25.
//

import SwiftUI

struct ProfileInfoView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTab: ProfileDetailCase = .about
    @Namespace var profileAnimation
    var profile: ProfilesData
    
    var body: some View {
        NavigationStack {
            VStack {
                ProfileImage(profile: profile)
                profileDetails
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ProfileInfoView(profile: profilesPreview.instance.sampleProfile)
}

extension ProfileInfoView {
    
    var profileDetails: some View {
        ZStack(alignment: .bottom){
            ScrollViewReader { proxy in
                tabSwitcher(proxy: proxy)
                    .padding(.horizontal)
                    .padding(.top)
                ScrollView(.vertical, showsIndicators: false) {
                    selectedTab.tabContentView(profile: profile)
                }
            }
            ActionButton(id: profile.id)
                .padding()
                .background{
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(Color.actionColorSet)
                }
                .padding()
        }
    }
    
    func tabSwitcher(proxy: ScrollViewProxy) -> some View {
        HStack {
            ForEach(ProfileDetailCase.allCases, id: \.self) { tab in
                VStack {
                    Text(tab.profileTabTitle)
                        .font(.subheadline)
                        .fontWeight(selectedTab == tab ? .semibold : .regular)
                        .foregroundColor(selectedTab == tab ? .primary : .gray)
                    if selectedTab == tab {
                        Capsule()
                            .fill(Color.blue)
                            .frame(height: 2)
                            .matchedGeometryEffect(id: "underline", in: profileAnimation)
                    } else {
                        Capsule()
                            .fill(Color.clear)
                            .frame(height: 2)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        selectedTab = tab
                        proxy.scrollTo(tab.scrollID, anchor: .top)
                    }
                }
                
                .frame(maxWidth: .infinity)
            }
        }
    }
}
